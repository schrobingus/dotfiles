{
  xresources.properties = {
    # Colorscheme is Tomorrow Night.

    "*.foreground" = "#c5c8c6";
    "*.background" = "#1d1f21";
    "*.cursorColor" = "#c5c8c6";

    # Black / Gray
    "*.color0" = "#000000";
    "*.color8" = "#808080";

    # Red
    "*.color1" = "#cc6666";
    "*.color9" = "#cc6666";

    # Green
    "*.color2" = "#b5bd68";
    "*.color10" = "#b5bd68";

    # Yellow
    "*.color3" = "#f0c674";
    "*.color11" = "#f0c674";

    # Blue
    "*.color4" = "#81a2be";
    "*.color12" = "#81a2be";

    # Purple
    "*.color5" = "#b294bb";
    "*.color13" = "#b294bb";

    # Cyan
    "*.color6" = "#8abeb7";
    "*.color14" = "#8abeb7";

    # White
    "*.color7" = "#c5c8c6";
    "*.color15" = "#c5c8c6";

    "URxvt.font" = "xft:GeistMono Nerd Font:style=Regular:size=9,xft:Symbola:style=Regular:size=9";
    "URxvt.boldFont" = "xft:GeistMono Nerd Font:style=Bold:size=9,xft:Symbola:style=Regular:size=9";
    "URxvt.italicFont" = " xft:GeistMono Nerd Font:style=Italic:size=9,xft:Symbola:style=Regular:size=9";
    "URxvt.boldItalicfont" = "xft:GeistMono Nerd Font:style=Bold Italic:size=9,xft:Symbola:style=Regular:size=9";
    "URxvt.letterSpace" = 0;
    "URxvt.lineSpace" = 0;
    "URxvt.geometry" = "400x400";
    "URxvt.internalBorder" = 10;
    "URxvt.cursorBlink" = true;
    "URxvt.cursorUnderline" = false;
    "URxvt.saveline" = 10000;
    "URxvt.scrollBar" = false;
    "URxvt.scrollBar_right" = false;
    "URxvt.urgentOnBell" = true;
    "URxvt.depth" = 10;
    "URxvt.iso14755" = false;

    "URxvt.keysym.Shift-Up" = "command:\033]720;1\007";
    "URxvt.keysym.Shift-Down" = "command:\033]721;1\007";
    "URxvt.keysym.Control-Up" = "\033[1;5A";
    "URxvt.keysym.Control-Down" = "\033[1;5B";
    "URxvt.keysym.Control-Right" = "\033[1;5C";
    "URxvt.keysym.Control-Left" = "\033[1;5D";

    "URxvt.perl-ext-common" = "default,clipboard,url-select,keyboard-select";
    "URxvt.copyCommand" = "xclip -i -selection clipboard";
    "URxvt.pasteCommand" = "xclip -o -selection clipboard";
    "URxvt.keysym.M-c" = "perl:clipboard:copy";
    "URxvt.keysym.M-v" = "perl:clipboard:paste";
    "URxvt.keysym.M-C-v" = "perl:clipboard:paste_escaped";
    "URxvt.keysym.M-Escape" = "perl:keyboard-select:activate";
    "URxvt.keysym.M-s" = "perl:keyboard-select:search";
    "URxvt.keysym.M-u" = "perl:url-select:select_next";
    "URxvt.urlLauncher" = "librewolf";
    "URxvt.underlineURLs" = true;
    "URxvt.urlButton" = 1;
  };
}
