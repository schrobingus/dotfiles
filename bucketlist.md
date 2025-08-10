
## The Problem

So far, I have hit an issue with the organization of my dotfiles overall, which is generally the organization of how I implement them. There is no problems regarding dotfile structure other than some Nix Store dependent byproducts, this is referring to how my configuration doesn't prioritize whether or not to use Nix for a certain set of configurations.

Before I had gone all in with Nix, it was mostly set so that the dotfiles themselves are independent, and Nix binds them together and manages them seamlessly on my system. However, over the past 2 years, I have noticed consistently that as I have become more invested in Nix and it's ecosystem, I have kind of bound most of my dotfiles to Nix in general, but some are also independent of Nix, and some do a combination of both.

There are a few issues with this approach:

- Managing dotfiles in this way becomes a pain, because I have to determine what goes into the store, and what doesn't. If I manage a dotfile in Nix by throwing it into the store, the linked dotfile now has to be updated by rebuilding the ENTIRE configuration over again, and if I manage it by just symlinking outside of the store, any integration or configuration with Nix is either dashed, or takes complexity as I have to integrate other dotfiles bound by the store or managed by Nix. **In other words, the objective is to pick a lane.**

- By having my dotfiles be so wishy-washy in this regard, I have effectively cripped how agnostic these dotfiles can be on most machines. Now, sure, these dotfiles will work fine on most Nix installations. However, single user Nix becomes very convoluted, and many of the machines in these scenarios have no root access. I do not want to spend time debugging my development environment during work hours, I want my shit to work. They're only plug and play if Nix is installed, which is easier said than done.

Now, to be clear, I do not want to get rid of Nix. It has been unanimously the best package manager and FP paradigm ecosystem I have been able to use in my experience, and it is the most organized and close knit piece of software I have ever used. However, the issue is not with Nix, it is with how I am using it, and I either have to let go of a lot of my dependence on it for basic dotfiles, or go all in entirely.

## The Plan

Based on reason 2, I have decided to go with the former option, which is to let go of much of the dependency I have when it comes to Nix. This will allow me to focus on my work first and foremost, with my dotfiles being plug and play on most systems, whether or not they have Nix. This does not include self-hosted services, those will still be managed by Nix overall, as those configurations are literally configured to run ongoingly, typically on my hardware.

**The overall goal is that Nix should be used to manage packages, and deploy my system AND my dotfiles, but only on my main machines or machines that I intend to use Nix with; I should be free to just copy or symlink my pre-existing dotfiles to any system without Nix, and they should just work with no issue and no need for interjection.**

### Potential Considerations

The plan first is to get my regular Vim configuration off the ground as a regular configuration that I plug in, and any vanilla binds and functionality that I have set should just work with no issue. However, I do progressively sense that my main editor (Neovim, managed with Nixvim) being bound to Nix may also provide a bottleneck to this entire purpose. As such, whilst I am not going to act on these as of writing this (07/10/25), I still want to write these ideas down:

- It might be an idea to move away from Nixvim and just rewrite my configuration in Lua. Sure, Nixvim is great, and it makes managing my Neovim configuration very easy, and it integrates with the rest of my system perfectly, but the hard dependency on Nix that it creates can be a roadblock in many cases.

- Another option is to potentially bite the bullet and move to another editor. 

  - Emacs is the one I have been majorly reconsidering, as it was what I used prior to switching to Neovim, and it can be used as a swiss army knife for effectively any traditional computer, both regarding editing and other tasks to be done. Whilst it replaces many essential functions in workflow, Emacs doesn't necessarily replace any functions on the system level. This makes it a perfect option to just drop onto any system where I have the capability to run portable executables, regardless of user level.

    - Org mode is great, and I would like to use it's functions, but I want it to be compatible with Markdown. This is not because I don't know how to use Org Mode or the Org language (I do), it's primarily because I want my notes to be accessible from anywhere, such as Nextcloud Notes, and still have the benefits (such as Org Agenda) on my Emacs configuration.

  - Another is VSCode, which could also come in the form of VSCodium or even Cursor (hey, I'm a student, don't beat me up over the free deal). This is primarily because many frameworks I use, such as Jupyter, primarily referring to it's kernel and notebook systems, integrate seamlessly with VSCode. The issue is that VSCode configurations get heavy fast, as I have to install entire extensions for basic syntax on an Electron app. Profiles exist, but I don't really think it's worth it. Emacs is probably better for the job, and it can at the very least be a swifter editor that VSCode is in full (even though Emacs in itself isn't that efficient of an editor either, but there is no hard dependency on effectively any functions in it, unlike VSCode, so it is much easier to optimize).

## What Needs Reimplementation

**First of all, what the fuck is going on with `darwin-rebuild` in the path? Fix that as soon as possible, so you don't have to keep using `nix run`.**

This is a list of the relation of each file in this repository to the goals I am trying to achieve:

- `config/`

  - `alacritty.toml`

    - This is a standalone dotfile, which means that this should be easily linkable with no issues. However, I'm honestly not sure if I need this anymore. I'll leave this in here for now, but I might remove it later. Also needs some updating.

  - `dunstrc`

    - This is a standalone dotfile, albeit I think this needs work in general. Test using the virtual machine.

  - `i3-config`

    - This is a standalone dotfile that needs not much editing.

  - `i3status-config`

    - This is a standalone dotfile that does not need much editing. However, I do want to eventually overhaul this.

  - `picom.conf`

    - This is a standalone dotfile.

  - `vimrc`

    - This is a standalone dotfile. However, I do want to have an option that either pulls from Vim packages out of scope (such as Home Manager) or optionally uses Plug.vim.

  - `vscode-settings.json`

    - This is a standalone dotfile. All this includes is VSCodeVim bindings.

  - `wezterm.lua`

    - This is a standalone dotfile. I like the state of my Wezterm config.

  - `Xresources`

    - **An insane mess.** Standalone, it does work as a standalone dotfile, but certain settings are bolstered by Home Manager. Also, much is out of date.

  - `zshrc`

    - **Currently dependent on Nix, but should not be.** This entire thing needs to be overdone to make more agnostic.

- `flake.nix`, `flake.lock`

  - Files necessary for Nix.

- `nix/`

  - `darwin/`

    - Runs under Nix Darwin. I want to keep my Darwin configuration Nix exclusive, because having set defaults is not a complete prerequesite for me to be able to use a Mac, obviously.

  - `home/`

    - `default.nix`

      - Runs under Nix. Nothing wrong with this main file for Home Manager.

    - `dunst.nix`

      - Runs under NixOS. Albeit, it's a bit dumb to have this in it's own Nix configuration, maybe truncate.

    - `files.nix`

      - **This is the file that binds all standalone dotfiles on my Nix configuration.**

      - Runs under Nix. I do want to make it so the sorted dotfiles are linked outside of the store, however.

    - `fonts.nix`

      - Runs under NixOS.

    - `git.nix`

      - Runs under Nix.

    - `nix-index-db.nix`

      - Runs under Nix.

    - `xresources.nix`

      - **Get rid of this.** This is muddying the waters between Nix and the standalone Nix dotfiles, and there is little to no advantage setting Xresources this way.

    - `zsh.nix`

      - **Strip this to just managing packages and instantiating Nix path, and move the configuration itself to zshrc.** This should not be needed to run the Zsh configuration properly.

  - `nixos/`

    - Runs under NixOS, and is meant to. Dotfiles are generally managed by Home Manager and not directly thrown here. Again, I want this to stay managed by Nix.

    - `interfaces/`

      - Runs under NixOS. Just to reiterate, this also does just instantiate system-wide set up. The i3 configuration is managed by Home Manager via it's specified dotfile, for example.

  - `shells/`

    - Runs under Nix. 

    - Right now, there is only one shell, which is meant for Data Science, and isn't really needed anymore since I either write a flake or use UV for this kind of setup. This also isn't really needed, because I now use Nix Comma (which is under the Nix Index Database module in my Home Manager configuration).

