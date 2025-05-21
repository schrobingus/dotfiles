# Comes from https://hg.sr.ht/%7Edermetfan/seaweedfs-nixos/browse/seaweedfs.nix?rev=tip

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.seaweedfs;

  clusterModule = cluster: {
    options = {
      package = mkOption {
        type = types.package;
        default = pkgs.seaweedfs;
      };

      security.grpc = let
        auth = mkOption {
          type = with types; nullOr (submodule {
            options = {
              cert = mkOption { type = path; };
              key = mkOption { type = path; };
            };
          });
          default = null;
        };
      in {
        ca = mkOption {
          type = with types; nullOr str;
          default = null;
        };

        master    = auth;
        volume    = auth;
        filer     = auth;
        client    = auth;
        msgBroker = auth;
      };

      masters = mkOption {
        type = with types; attrsOf (submodule (masterModule cluster.config));
        default = {};
        description = "SeaweedFS masters";
      };

      volumes = mkOption {
        type = with types; attrsOf (submodule (volumeModule cluster.config));
        default = {};
        description = "SeaweedFS volumes";
      };

      filers = mkOption {
        type = with types; attrsOf (submodule (filerModule cluster.config));
        default = {};
        description = "SeaweedFS filers";
      };

      webdavs = mkOption {
        type = with types; attrsOf (submodule (webdavModule cluster.config));
        default = {};
        description = "SeaweedFS WebDAV servers";
      };

      instances = mkOption {
        type = with types; attrsOf (submodule instanceModule);
        description = "SeaweedFS instances";
        default =
          mapAttrs' (name: master: nameValuePair
            "master-${name}"
            {
              inherit (master) cluster configs;

              command = "master";

              args = with master;
                [
                  "-port=${toString port}"
                  "-volumeSizeLimitMB=${toString volumeSizeLimitMB}"
                ] ++
                optional (cpuprofile != "") "-cpuprofile=${cpuprofile}" ++
                optional (defaultReplication != null) ("-defaultReplication=${defaultReplication.code}") ++
                optional disableHttp "-disableHttp" ++
                optional (garbageThreshold != "") "-garbageThreshold=${garbageThreshold}" ++
                optional (ip != "") "-ip=${ip}" ++
                optional (master."ip.bind" != "") "-ip.bind=${master."ip.bind"}" ++
                optional (mdir != "") "-mdir=${mdir}" ++
                optional (memprofile != "") "-memprofile=${memprofile}" ++
                optional metrics.enable "-metrics.address=${metrics.address.text}" ++
                optional (metrics.intervalSeconds != null) "-metrics.intervalSeconds=${toString metrics.intervalSeconds}" ++
                optional (peers != []) ("-peers=" + (concatStringsSep "," (map (peer: peer.text) peers))) ++
                optional resumeState "-resumeState" ++
                optional volumePreallocate "-volumePreallocate" ++
                optional (whiteList != []) ("-whiteList=" + (concatStringsSep "," whiteList));
            }
          ) cluster.config.masters //
          mapAttrs' (name: volume: nameValuePair
            "volume-${name}"
            {
              inherit (volume) cluster configs;

              command = "volume";

              args = with volume;
                [
                  "-port=${toString port}"
                  "-dir=${concatStringsSep "," dir}"
                  "-fileSizeLimitMB=${toString fileSizeLimitMB}"
                  "-idleTimeout=${toString idleTimeout}"
                  "-index=${index}"
                  "-minFreeSpacePercent=${toString minFreeSpacePercent}"
                  "-preStopSeconds=${toString preStopSeconds}"
                ] ++
                optional (compactionMBps != null) ("-compactionMBps=${compactionMBps}") ++
                optional (cpuprofile != "") "-cpuprofile=${cpuprofile}" ++
                optional (dataCenter != "") "-dataCenter=${dataCenter}" ++
                optional volume."images.fix.orientation" "-images.fix.orientation" ++
                optional (ip != "") "-ip=${ip}" ++
                optional (volume."ip.bind" != "") "-ip.bind=${volume."ip.bind"}" ++
                optional (max != []) "-max=${concatStringsSep "," (map toString max)}" ++
                optional (memprofile != "") "-memprofile=${memprofile}" ++
                optional (metricsPort != null) "-metricsPort=${toString metricsPort}" ++
                optional (mserver != []) ("-mserver=" + (concatStringsSep "," (map (mserver: mserver.text) mserver))) ++
                optional (volume."port.public" != null) "-port.public=${toString volume."port.public"}" ++
                optional pprof "-pprof" ++
                optional (publicUrl != "") "-publicUrl=${publicUrl}" ++
                optional (rack != "") "-rack=${rack}" ++
                optional (!volume."read.redirect") "-read.redirect=false" ++
                optional (whiteList != []) ("-whiteList=" + (concatStringsSep "," whiteList));

              systemdService.preStart = "mkdir -p ${concatStringsSep " " volume.dir}";
            }
          ) cluster.config.volumes //
          mapAttrs' (name: filer: nameValuePair
            "filer-${name}"
            {
              inherit (filer) cluster configs;

              command = "filer";

              args = with filer;
                [
                  "-port=${toString port}"
                  "-dirListLimit=${toString dirListLimit}"
                  "-maxMB=${toString maxMB}"
                ] ++
                optional (collection != "") "-collection=${collection}" ++
                optional (dataCenter != "") "-dataCenter=${dataCenter}" ++
                optional (defaultReplicaPlacement != null) ("-defaultReplicaPlacement=${defaultReplicaPlacement.code}") ++
                optional disableDirListing "-disableDirListing" ++
                optional disableHttp "-disableHttp" ++
                optional encryptVolumeData "-encryptVolumeData" ++
                optional (ip != "") "-ip=${ip}" ++
                optional (filer."ip.bind" != "") "-ip.bind=${filer."ip.bind"}" ++
                optional (master != []) ("-master=" + (concatStringsSep "," (map (master: master.text) master))) ++
                optional (metricsPort != null) "-metricsPort=${toString metricsPort}" ++
                optional (peers != []) ("-peers=" + (concatStringsSep "," (map (peer: peer.text) peers))) ++
                optional (filer."port.readonly" != null) "-port.readonly=${toString filer."port.readonly"}" ++
                optional (rack != "") "-rack=${rack}" ++
                optionals s3.enable [
                  "-s3"
                  "-s3.port=${toString filer.s3.port}"
                ] ++
                optional (s3.enable && s3."cert.file" != "") "-s3.cert.file=${s3."cert.file"}" ++
                optional (s3.enable && s3."key.file" != "") "-s3.key.file=${s3."key.file"}" ++
                optional (s3.enable && s3.config != "") "-s3.config=${s3.config}" ++
                optional (s3.enable && s3.domainName != []) "-s3.domainName=${concatStringsSep "," s3.domainName}";

              systemdService.preStart = let
                conf = filer.configs.filer.leveldb2 or {};
              in optionalString (conf ? "dir") "mkdir -p ${conf.dir}";
            }
          ) cluster.config.filers //
          mapAttrs' (name: webdav: nameValuePair
            "webdav-${name}"
            {
              inherit (webdav) cluster;

              command = "webdav";

              args = with webdav;
                [
                  "-port=${toString port}"
                  "-filer=${filer.text}"
                  "-cacheCapacityMB=${toString cacheCapacityMB}"
                ] ++
                optional (collection != "") "-collection=${collection}" ++
                optional (cacheDir != "") "-cacheDir=${cacheDir}";
            }
          ) cluster.config.webdavs;
      };
    };
  };

  commonModule = cluster: common: {
    options = {
      cluster = mkOption {
        type = types.submodule clusterModule;
        internal = true;
      };

      openFirewall = mkEnableOption "open the firewall";
    };

    config = { inherit cluster; };
  };

  masterModule = cluster: master: {
    imports = [ (commonModule cluster) ];

    options = {
      configs = mkOption {
        type = with types; attrsOf attrs;
        default.master.maintenance = {
          scripts = ''
            ec.encode -fullPercent=95 -quietFor=1h
            ec.rebuild -force
            ec.balance -force
            volume.balance -force
            volume.fix.replication
          '';
          sleep_minutes = 17;
        };
      };

      cpuprofile = mkOption {
        type = types.str;
        default = "";
      };

      defaultReplication = mkOption {
        type = types.submodule replicationModule;
        default = {};
      };

      disableHttp = mkEnableOption "disable HTTP requests, gRPC only";

      garbageThreshold = mkOption {
        type = types.str;
        default = "";
      };

      ip = mkOption {
        type = types.str;
        default = config.networking.hostName;
      };

      "ip.bind" = mkOption {
        type = types.str;
        default = "0.0.0.0";
      };

      mdir = mkOption {
        type = types.str;
        default = ".";
      };

      memprofile = mkOption {
        type = types.str;
        default = "";
      };

      metrics = {
        enable = mkEnableOption "Prometheus";

        address = mkOption {
          type = types.submodule ipPortModule;
          default = {};
        };

        intervalSeconds = mkOption {
          type = types.ints.unsigned;
          default = 15;
        };
      };

      peers = mkOption {
        type = peersType;
        default = mapAttrsIpPort master.config.cluster.masters;
      };

      port = mkOption {
        type = types.port;
        default = 9333;
      };

      resumeState = mkEnableOption "resume previous state on master server";

      volumePreallocate = mkEnableOption "preallocate disk space for volumes";

      volumeSizeLimitMB = mkOption {
        type = types.ints.unsigned;
        default = 30000;
      };

      whiteList = mkOption {
        type = with types; listOf str;
        default = [];
      };
    };
  };

  volumeModule = cluster: volume: {
    imports = [ (commonModule cluster) ];

    options = {
      configs = mkOption {
        type = with types; attrsOf attrs;
        default = {};
      };

      compactionMBps = mkOption {
        type = with types; nullOr ints.unsigned;
        default = null;
      };

      cpuprofile = mkOption {
        type = types.str;
        default = "";
      };

      dataCenter = mkOption {
        type = types.str;
        default = "";
      };

      dir = mkOption {
        type = with types; listOf str;
        default = [ "/var/lib/seaweedfs/${cluster._module.args.name}/volume-${volume.config._module.args.name}" ];
      };

      fileSizeLimitMB = mkOption {
        type = types.ints.unsigned;
        default = 256;
      };

      idleTimeout = mkOption{
        type = types.ints.unsigned;
        default = 30;
      };

      "images.fix.orientation" = mkEnableOption "adjustment of jpg orientation when uploading";

      index = mkOption {
        type = types.enum [
          "memory"
          "leveldb"
          "leveldbMedium"
          "leveldbLarge"
        ];
        default = "memory";
      };

      ip = mkOption {
        type = types.str;
        default = config.networking.hostName;
      };

      "ip.bind" = mkOption {
        type = types.str;
        default = "0.0.0.0";
      };

      max = mkOption {
        type = with types; listOf ints.unsigned;
        default = [ 8 ];
      };

      memprofile = mkOption {
        type = types.str;
        default = "";
      };

      metricsPort = mkOption {
        type = with types; nullOr port;
        default = null;
      };

      minFreeSpacePercent = mkOption {
        type = types.ints.unsigned;
        default = 1;
      };

      mserver = mkOption {
        type = peersType;
        default = mapAttrsIpPort volume.config.cluster.masters;
      };

      port = mkOption {
        type = types.port;
        default = 8080;
      };

      "port.public" = mkOption {
        type = with types; nullOr port;
        default = null;
      };

      pprof = mkEnableOption "pprof http handlers. precludes -memprofile and -cpuprofile";

      preStopSeconds = mkOption {
        type = types.int;
        default = 10;
      };

      publicUrl = mkOption {
        type = types.str;
        default = "";
      };

      rack = mkOption {
        type = types.str;
        default = "";
      };

      "read.redirect" = mkOption {
        type = types.bool;
        default = true;
      };

      whiteList = mkOption {
        type = with types; listOf str;
        default = [];
      };
    };
  };

  filerModule = cluster: filer: {
    imports = [ (commonModule cluster) ];

    options = {
      configs = mkOption {
        type = with types; attrsOf attrs;
        default.filer.leveldb2 = {
          enabled = true;
          dir = "/var/lib/seaweedfs/${cluster._module.args.name}/filer-${filer.config._module.args.name}/filerldb2";
        };
      };

      collection = mkOption {
        type = types.str;
        default = "";
      };

      dataCenter = mkOption {
        type = types.str;
        default = "";
      };

      defaultReplicaPlacement = mkOption {
        type = with types; nullOr (submodule replicationModule);
        default = null;
      };

      dirListLimit = mkOption {
        type = types.ints.unsigned;
        default = 100000;
      };

      disableDirListing = mkEnableOption "turn off directory listing";

      disableHttp = mkEnableOption "disable http request, only gRpc operations are allowed";

      encryptVolumeData = mkEnableOption "encrypt data on volume servers";

      ip = mkOption {
        type = types.str;
        default = config.networking.hostName;
      };

      "ip.bind" = mkOption {
        type = types.str;
        default = "0.0.0.0";
      };

      master = mkOption {
        type = peersType;
        default = mapAttrsIpPort filer.config.cluster.masters;
      };

      maxMB = mkOption {
        type = types.ints.unsigned;
        default = 32;
      };

      metricsPort = mkOption {
        type = with types; nullOr port;
        default = null;
      };

      peers = mkOption {
        type = peersType;
        default = mapAttrsIpPort filer.config.cluster.filers;
      };

      port = mkOption {
        type = types.port;
        default = 8888;
      };

      "port.readonly" = mkOption {
        type = with types; nullOr port;
        default = null;
      };

      rack = mkOption {
        type = types.str;
        default = "";
      };

      s3 = {
        enable = mkEnableOption "whether to start S3 gateway";

        "cert.file" = mkOption {
          type = types.path;
          default = "";
        };

        config = mkOption {
          type = types.path;
          default = "";
        };

        domainName = mkOption {
          type = with types; listOf str;
          default = [];
        };

        "key.file" = mkOption {
          type = types.path;
          default = "";
        };

        port = mkOption {
          type = types.port;
          default = 8333;
        };
      };
    };
  };

  webdavModule = cluster: webdav: {
    imports = [ (commonModule cluster) ];

    options = {
      cacheCapacityMB = mkOption {
        type = types.int;
        default = 1000;
      };

      cacheDir = mkOption {
        type = types.str;
        default = ".";
      };

      collection = mkOption {
        type = types.str;
        default = "";
      };

      filer = mkOption {
        type = types.submodule ipPortModule;
        default = {
          ip = "127.0.0.1";
          port = 8888;
        };
      };

      port = mkOption {
        type = types.port;
        default = 7333;
      };
    };
  };

  instanceModule = instance: {
    options = {
      cluster = mkOption {
        type = types.submodule clusterModule;
        internal = true;
      };

      command = mkOption {
        type = types.enum [
          "server"
          "master"
          "volume"
          "mount"
          "filer"
          "filer.replicate"
          "filer.sync"
          "s3"
          "msgBroker"
          "watch"
          "webdav"
        ];
      };

      logArgs = mkOption {
        type = with types; listOf str;
        default = [];
      };

      args = mkOption {
        type = with types; listOf str;
        default = [];
      };

      configs = mkOption {
        type = with types; attrsOf attrs;
        default = {};
      };

      package = mkOption {
        type = types.package;
        default = instance.config.cluster.package;
      };

      systemdService = mkOption {
        type = types.attrs;
        default = {};
      };
    };

    config = {
      logArgs = [ "-logtostderr" ];

      systemdService.path = optional (instance.config.command == "mount") pkgs.fuse;
    };
  };

  replicationModule = replication: {
    options = {
      dataCenter = mkOption {
        type = types.ints.between 0 9;
        default = 0;
      };

      rack = mkOption {
        type = types.ints.between 0 9;
        default = 0;
      };

      server = mkOption {
        type = types.ints.between 0 9;
        default = 0;
      };

      code = mkOption {
        readOnly = true;
        internal = true;
        type = types.str;
        default = with replication.config; "${toString dataCenter}${toString rack}${toString server}";
      };
    };
  };

  peersType = with types; listOf (submodule ipPortModule);

  ipPortModule = ipPort: {
    options = {
      ip = mkOption {
        type = types.str;
      };

      port = mkOption {
        type = types.port;
      };

      text = mkOption {
        internal = true;
        readOnly = true;
        type = types.str;
        default = with ipPort.config; "${ip}:${toString port}";
      };
    };
  };

  mapAttrsIpPort = attrs: mapAttrsToList (name: value: { inherit (value) ip port; }) attrs;

  toTOML = with generators; toINI {
    mkKeyValue = mkKeyValueDefault {
      mkValueString = v:
        if isString v
        then (
          if hasInfix "\n" v
          then ''
            """
            ${removeSuffix "\n" v}
            """
          ''
          else ''"${v}"''
        )
        else mkValueStringDefault {} v;
    } "=";
  };

  flattenAttrs = separator: attrs: let
    /*
    attrs = {
      a = {
        m1 = {};
        m2 = {};
      };
      b = {
        m1 = {};
      };
    }
    */

    /*
    step1 = {
      a = [
        { name = "a-m1"; value = {}; }
        { name = "a-m2"; value = {}; }
      ];
      b = [
        { name = "b-m1"; value = {}; }
      ];
    };
    */
    step1 = mapAttrs (outerName: outerValues:
      mapAttrsToList (innerName: innerValues: nameValuePair
        "${outerName}${separator}${innerName}"
        innerValues
      ) outerValues
    ) attrs;

    /*
    step2 = [
      [
        { name = "a-m1"; value = {}; }
        { name = "a-m2"; value = {}; }
      ]
      [
        { name = "b-m1"; value = {}; }
      ]
    ];
    */
    step2 = mapAttrsToList (name: value: value) step1;

    /*
    step3 = [
      { name = "a-m1"; value = {}; }
      { name = "a-m2"; value = {}; }
      { name = "b-m1"; value = {}; }
    ];
    */
    step3 = flatten step2;
  in
    /*
    {
      a-m1 = {};
      a-m2 = {};
      b-m1 = {};
    };
    */
    builtins.listToAttrs step3;
in {
  options.services.seaweedfs = {
    clusters = mkOption {
      type = with types; attrsOf (submodule clusterModule);
      default = {};
      description = "SeaweedFS clusters";
    };
  };

  config = {
    systemd.services = mapAttrs'
      (name: instance: nameValuePair "seaweedfs-${name}" instance)
      (flattenAttrs "-" (
        mapAttrs (clusterName: cluster:
          mapAttrs (instanceName: instance: with instance; recursiveUpdate systemdService rec {
            description = "SeaweedFS ${clusterName} ${instanceName}";
            wants = [ "network.target" ];
            after = wants;
            wantedBy = [ "multi-user.target" ];
            preStart = with serviceConfig; ''
              ${
                let securityFile = config.environment.etc."seaweedfs/${clusterName}/security.toml";
                in optionalString securityFile.enable "ln -s /etc/${securityFile.target} ${WorkingDirectory}/"
              }

              # TODO replace find usage with statically known condition
              find -L /etc/${ConfigurationDirectory} -type f -exec ln -s '{}' ${WorkingDirectory}/ \;

              ${optionalString (systemdService ? preStart) systemdService.preStart}
            '';
            serviceConfig = rec {
              ExecStart = "${package}/bin/weed ${concatStringsSep " " logArgs} ${command} ${concatStringsSep " " args}";
              Restart = "on-failure";
              Type = "exec";
              ConfigurationDirectory = "seaweedfs/${clusterName}/${instanceName}";
              RuntimeDirectory = ConfigurationDirectory;
              RuntimeDirectoryPreserve = "restart";
              WorkingDirectory = "/run/${RuntimeDirectory}";
            };
          }) cluster.instances
        ) cfg.clusters
      ));

    environment.etc =
      (mapAttrs' (name: cluster:
        let file = "seaweedfs/${name}/security.toml";
        in nameValuePair file {
          enable = config.environment.etc.${file}.text != "";
          text = with cluster.security.grpc; toTOML (
            (if ca        == null then {} else { grpc.ca = ca; }) //
            (if master    == null then {} else { "grpc.master"     = { inherit (master)    cert key; }; }) //
            (if volume    == null then {} else { "grpc.volume"     = { inherit (volume)    cert key; }; }) //
            (if filer     == null then {} else { "grpc.filer"      = { inherit (filer)     cert key; }; }) //
            (if client    == null then {} else { "grpc.client"     = { inherit (client)    cert key; }; }) //
            (if msgBroker == null then {} else { "grpc.msg_broker" = { inherit (msgBroker) cert key; }; })
          );
        }
      ) cfg.clusters) //
      (mapAttrs'
        (name: config: nameValuePair
          "seaweedfs/${name}.toml"
          { text = toTOML config; }
        )
        (flattenAttrs "/" (
          mapAttrs (clusterName: cluster:
            flattenAttrs "/" (
              mapAttrs
                (instanceName: instance: instance.configs)
                cluster.instances
            )
          ) cfg.clusters
        ))
      );

    networking.firewall.allowedTCPPorts = let
      modulesToPorts = extraPorts: mapAttrsToList (name: module:
        with module;
        optionals openFirewall (
          [ port (port + 10000) ] ++
          (filter (p: p != null) (extraPorts module))
        )
      );
    in flatten (mapAttrsToList (clusterName: cluster:
      modulesToPorts
        (master: [])
        cluster.masters ++

      modulesToPorts
        (volume: with volume; [ metricsPort volume."port.public" ])
        cluster.volumes ++

      modulesToPorts
        (filer: with filer; [ metricsPort filer."port.readonly" s3.port])
        cluster.filers ++

      modulesToPorts
        (webdav: [])
        cluster.webdavs
    ) cfg.clusters);
  };
}
