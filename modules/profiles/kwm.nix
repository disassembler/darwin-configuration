{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.kwm;
in {
  options.profiles.kwm = {
    enable = mkEnableOption "KWM Config";
  };

  config = mkIf (cfg.enable)  {
    environment.systemPackages = [ pkgs.kwm pkgs.khd ];
    services.khd.enable = true;
    services.kwm.enable = true;
    services.khd.khdConfig = ''
      # remap left-control h/j/k/l -> arrow keys
      lctrl - h         [Safari]      :   khd -p "- left"
      lctrl - j         [Safari]      :   khd -p "- down"
      lctrl - k         [Safari]      :   khd -p "- up"
      lctrl - l         [Safari]      :   khd -p "- right"

      shift + lctrl - h [Safari]      :   khd -p "shift - left"
      shift + lctrl - j [Safari]      :   khd -p "shift - down"
      shift + lctrl - k [Safari]      :   khd -p "shift - up"
      shift + lctrl - l [Safari]      :   khd -p "shift - right"

      # remap left-control a / e   -> start / end of line
      lctrl - a         [Safari]      :   khd -p "cmd - left"
      lctrl - e         [Safari]      :   khd -p "cmd - right"

      shift + lctrl - e [Safari]      :   khd -p "shift + cmd - left"
      shift + lctrl - e [Safari]      :   khd -p "shift + cmd - right"

      # remap left-control b / w   -> start / end of word
      lctrl - b         [Safari]      :   khd -p "alt - left"
      lctrl - w         [Safari]      :   khd -p "alt - right"

      shift + lctrl - b [Safari]      :   khd -p "shift + alt - left"
      shift + lctrl - w [Safari]      :   khd -p "shift + alt - right"

      # remap left-control u / d   -> page up / page down
      lctrl - u         [Safari]      :   khd -p "alt - up"
      lctrl - d         [Safari]      :   khd -p "alt - down"

      shift + lctrl - u [Safari]      :   khd -p "shift + alt - up"
      shift + lctrl - d [Safari]      :   khd -p "shift + alt - down"

      # remap left-control x       -> forward delete
      lctrl - x         [Safari]      :   khd -p "- delete"

      # remap left-control g       -> escape
      lctrl - g         [Safari]      :   khd -p "0x35"


      # modifier only mappings
      khd mod_trigger_timeout 0.2
      lctrl    :   khd -p "0x35"
      lshift   :   khd -p "shift - 9"
      rshift   :   khd -p "shift - 0"


      # enable kwm compatibility mode
      khd kwm on


      # set border color for different modes
      # khd mode default color 0xddd5c4a1
      khd mode default color 0x00000000
      khd mode switcher color 0xddbdd322
      khd mode scratchpad color 0xddd75f5f
      khd mode swap color 0xdd458588
      khd mode tree color 0xddfabd2f
      khd mode space color 0xddb16286
      khd mode info color 0xddcd950c


      # toggle between modes
      alt - f                 :   khd -e "mode activate switcher"
      switcher + alt - f      :   khd -e "mode activate default"
      swap + alt - f          :   khd -e "mode activate switcher"
      space + alt - f         :   khd -e "mode activate switcher"
      tree + alt - f          :   khd -e "mode activate switcher"
      info + alt - f          :   khd -e "mode activate switcher"
      scratchpad + alt - f    :   khd -e "mode activate switcher"

      switcher + alt - g      :   khd -e "mode activate default"
      swap + alt - g          :   khd -e "mode activate default"
      space + alt - g         :   khd -e "mode activate default"
      tree + alt - g          :   khd -e "mode activate default"
      info + alt - g          :   khd -e "mode activate default"
      scratchpad + alt - g    :   khd -e "mode activate default"
      switcher + ctrl - g     :   khd -e "mode activate default"
      swap + ctrl - g         :   khd -e "mode activate default"
      space + ctrl - g        :   khd -e "mode activate default"
      tree + ctrl - g         :   khd -e "mode activate default"
      info + ctrl - g         :   khd -e "mode activate default"
      scratchpad + ctrl - g   :   khd -e "mode activate default"
      switcher - 0x35         :   khd -e "mode activate default"
      swap - 0x35             :   khd -e "mode activate default"
      space - 0x35            :   khd -e "mode activate default"
      tree - 0x35             :   khd -e "mode activate default"
      info - 0x35             :   khd -e "mode activate default"
      scratchpad - 0x35       :   khd -e "mode activate default"

      switcher - w            :   khd -e "mode activate scratchpad"
      switcher - a            :   khd -e "mode activate swap"
      switcher - s            :   khd -e "mode activate space"
      switcher - d            :   khd -e "mode activate tree"
      switcher - q            :   khd -e "mode activate info"


      # switcher mode
      switcher + shift - r    :   killall kwm;\
                                  khd -e "reload";\
                                  khd -e "mode activate default"

      switcher - return       :   open -na /Applications/iTerm.app;\
                                  khd -e "mode activate default"

      switcher - h            :   kwmc window -f west
      switcher - l            :   kwmc window -f east
      switcher - j            :   kwmc window -f south
      switcher - k            :   kwmc window -f north
      switcher - n            :   kwmc window -fm prev
      switcher - m            :   kwmc window -fm next

      switcher - 1            :   kwmc space -fExperimental 1
      switcher - 2            :   kwmc space -fExperimental 2
      switcher - 3            :   kwmc space -fExperimental 3
      switcher - 4            :   kwmc space -fExperimental 4
      switcher - 5            :   kwmc space -fExperimental 5
      switcher - 6            :   kwmc space -fExperimental 6

      switcher + shift - 1    :   kwmc display -f 0
      switcher + shift - 2    :   kwmc display -f 1
      switcher + shift - 3    :   kwmc display -f 2


      scratchpad - a          :   kwmc scratchpad add
      scratchpad - s          :   kwmc scratchpad toggle 0
      scratchpad - d          :   kwmc scratchpad remove

      scratchpad - 1          :   kwmc scratchpad toggle 1
      scratchpad - 2          :   kwmc scratchpad toggle 2
      scratchpad - 3          :   kwmc scratchpad toggle 3
      scratchpad - 4          :   kwmc scratchpad toggle 4
      scratchpad - 5          :   kwmc scratchpad toggle 5
      scratchpad - 6          :   kwmc scratchpad toggle 6


      # swap mode
      swap - h                :   kwmc window -s west
      swap - j                :   kwmc window -s south
      swap - k                :   kwmc window -s north
      swap - l                :   kwmc window -s east
      swap - m                :   kwmc window -s mark

      swap + shift - k        :   kwmc window -m north
      swap + shift - l        :   kwmc window -m east
      swap + shift - j        :   kwmc window -m south
      swap + shift - h        :   kwmc window -m west
      swap + shift - m        :   kwmc window -m mark

      swap - 1                :   kwmc window -m space 1
      swap - 2                :   kwmc window -m space 2
      swap - 3                :   kwmc window -m space 3
      swap - 4                :   kwmc window -m space 4
      swap - 5                :   kwmc window -m space 5

      swap - z                :   kwmc window -m space left
      swap - c                :   kwmc window -m space right

      swap + shift - 1        :   kwmc window -m display 0
      swap + shift - 2        :   kwmc window -m display 1
      swap + shift - 3        :   kwmc window -m display 2


      # space mode
      space - a               :   kwmc space -t bsp
      space - s               :   kwmc space -t monocle
      space - d               :   kwmc space -t float

      space - x               :   kwmc space -g increase horizontal
      space - y               :   kwmc space -g increase vertical

      space + shift - x       :   kwmc space -g decrease horizontal
      space + shift - y       :   kwmc space -g decrease vertical

      space - left            :   kwmc space -p increase left
      space - right           :   kwmc space -p increase right
      space - up              :   kwmc space -p increase top
      space - down            :   kwmc space -p increase bottom
      space - p               :   kwmc space -p increase all

      space + shift - left    :   kwmc space -p decrease left
      space + shift - right   :   kwmc space -p decrease right
      space + shift - up      :   kwmc space -p decrease top
      space + shift - down    :   kwmc space -p decrease bottom
      space + shift - p       :   kwmc space -p decrease all


      # tree mode
      tree - a                :   kwmc window -c type bsp
      tree - s                :   kwmc window -c type monocle
      tree - f                :   kwmc window -z fullscreen
      tree - d                :   kwmc window -z parent
      tree - w                :   kwmc window -t focused
      tree - r                :   kwmc tree rotate 90

      tree - q                :   kwmc window -c split - mode toggle;\
                                  khd -e "mode activate default"

      tree - c                :   kwmc window -c type toggle;\
                                  khd -e "mode activate default"

      tree - h                :   kwmc window -c expand 0.05 west
      tree - j                :   kwmc window -c expand 0.05 south
      tree - k                :   kwmc window -c expand 0.05 north
      tree - l                :   kwmc window -c expand 0.05 east
      tree + shift - h        :   kwmc window -c reduce 0.05 west
      tree + shift - j        :   kwmc window -c reduce 0.05 south
      tree + shift - k        :   kwmc window -c reduce 0.05 north
      tree + shift - l        :   kwmc window -c reduce 0.05 east

      tree - p                :   kwmc tree -pseudo create
      tree + shift - p        :   kwmc tree -pseudo destroy

      tree - o                :   kwmc window -s prev
      tree + shift - o        :   kwmc window -s next
    '';

    services.kwm.kwmConfig = ''
      kwmc config tiling bsp
      kwmc config split-ratio 0.5
      kwmc config spawn left


      kwmc config padding 28 0 2 0
      kwmc config gap 4 4
      kwmc config display 1 padding 40 20 20 20
      kwmc config display 1 gap 10 10
      kwmc config display 2 padding 40 20 20 20
      kwmc config display 2 gap 10 10

      kwmc config space 0 1 name main
      kwmc config space 0 2 name web
      kwmc config space 0 2 mode monocle
      kwmc config space 0 3 name keepass
      kwmc config space 0 4 name chat
      kwmc config space 0 4 mode monocle

      kwmc config focus-follows-mouse on
      kwmc config mouse-follows-focus on
      kwmc config standby-on-float on
      kwmc config center-on-float on
      kwmc config float-non-resizable on
      kwmc config lock-to-container on
      kwmc config cycle-focus on
      kwmc config optimal-ratio 1.605

      kwmc config border focused on
      kwmc config border focused size 2
      kwmc config border focused color 0x00000000
      kwmc config border focused radius 6

      kwmc config border marked on
      kwmc config border marked size 2
      kwmc config border marked color 0xDD7f7f7f
      kwmc config border marked radius 6

      kwmc rule owner="Airmail" properties={float="true"}
      kwmc rule owner="Apple Store" properties={float="true"}
      kwmc rule owner="Skype for Business" properties={float="true"}
      kwmc rule owner="Info" properties={float="true"}
      kwmc rule owner="System Preferences" properties={float="true"}
      kwmc rule owner="iTerm2" properties={role="AXDialog"}
      kwmc rule owner="iTunes" properties={float="true"}
    '';
  };
}
