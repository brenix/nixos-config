{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    corefonts
    cozette
    dejavu_fonts
    dina-font
    gohufont
    hack-font
    liberation_ttf
    material-icons
    noto-fonts
    open-sans
    roboto
    tamzen
    terminus_font
    ubuntu_font_family
    uw-ttyp0
    vistafonts
    weather-icons
    (nerdfonts.override {
      fonts = [ "Gohu" "JetBrainsMono" "RobotoMono" "UbuntuMono" ];
    })
  ];


  fonts.fontconfig = {
    localConf = ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
      <fontconfig>
        <!-- Replacements from http://bohoomil.com/doc/05-fonts/ (until ibfonts-meta-extended) -->
        <alias>
          <family>serif</family>
          <prefer><family>Heuristica</family></prefer>
        </alias>
        <alias>
          <family>sans-serif</family>
          <prefer><family>Noto Sans</family></prefer>
        </alias>
        <alias>
          <family>monospace</family>
          <prefer><family>Liberation Mono</family></prefer>
        </alias>
        <alias>
          <family>fantasy</family>
          <prefer><family>Signika</family></prefer>
        </alias>
        <alias>
          <family>cursive</family>
          <prefer><family>TeX Gyre Chorus</family></prefer>
        </alias>
        <match>
          <test name="family"><string>Arial</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Arial Narrow</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Sans Narrow</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Book Antiqua</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>TeX Gyre Bonum</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Calibri</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Carlito</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Cambria</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Caladea</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>New Century Schoolbook</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>TeX Gyre Schola</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Comic Sans MS</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Signika</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Consolas</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Droid Sans Mono Slashed</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Constantia</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Merriweather</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Corberl</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Merriweather Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Courier New</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Courier Prime</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Geneva</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Noto Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Georgia</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Gelasio</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Helvetica</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Helvetica Narrow</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Sans Narrow</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Helvetica Neue</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Open Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Impact</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Oswald</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>ITC Zapf Chancery</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>TeX Gyre Chorus</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Calligraphy</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Quintessential</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Handwriting</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Quintessential</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Casual</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>CantoraOne</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Console</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Droid Sans Mono</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Sans Typewriter</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Sans Mono</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Fax</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Luxi Mono</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Sans</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Droid Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Lucida Grande</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Droid Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Palatino Linotype</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>TeX Gyre Pagella</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>SegoeUI</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>WeblySleek UI</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Symbol</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Symbola</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Tahoma</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>DejaVu Sans Condensed</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Times New Roman</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Liberation Serif</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Trebuchet MS</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Ubuntu</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Verdana</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>DejaVu Sans</string>
          </edit>
        </match>
        <match>
          <test name="family"><string>Wingdings</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Symbola</string>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
