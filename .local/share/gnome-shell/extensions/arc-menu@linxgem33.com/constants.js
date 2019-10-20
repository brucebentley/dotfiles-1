/*
 * Arc Menu: The new applications menu for Gnome 3.
 *
 * Copyright (C) 2017-2019 LinxGem33 
 *
 * Copyright (C) 2019 Andrew Zaech 
 * 
 * Copyright (C) 2017 Alexander Rüedlinger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Common constants that are used in this extension

var ARC_MENU_LOGO = {
    Path: '/media/ArcMenu-logo.svg',
    Size: [175, 175] // width, height
};
var COLOR_PRESET = {
    Path: '/media/color-preset.svg',
    Size: [200, 35] // width, height
};

var CURRENT_MENU = {
    FAVORITES: 0,
    CATEGORIES: 1,
    CATEGORY_APPLIST: 2,
    SEARCH_RESULTS: 3
};

var SEPARATOR_ALIGNMENT = {
    VERTICAL: 0,
    HORIZONTAL: 1
};
var SEPARATOR_STYLE = {
    NORMAL: 0,
    LONG: 1,
    SHORT: 2
};

var DEFAULT_DIRECTORIES = [
    imports.gi.GLib.UserDirectory.DIRECTORY_DOCUMENTS,
    imports.gi.GLib.UserDirectory.DIRECTORY_DOWNLOAD,
    imports.gi.GLib.UserDirectory.DIRECTORY_MUSIC,
    imports.gi.GLib.UserDirectory.DIRECTORY_PICTURES,
    imports.gi.GLib.UserDirectory.DIRECTORY_VIDEOS
];

var DEFAULT_ICON_SIZE = 22;

var SHORTCUTS = [
    {
        label: ("Software"),
        symbolic: "org.gnome.Software-symbolic",
        command: "gnome-software"
    },
    {
        label: ("Software"),
        symbolic: "org.gnome.Software-symbolic",
        command: "pamac-manager"
    },
    {
        label: ("Settings"),
        symbolic: "preferences-system-symbolic",
        command: "gnome-control-center"
    },
    {
        label: ("Tweaks"), // Tweak Tool is called Tweaks in GNOME 3.26
        symbolic: "org.gnome.tweaks-symbolic",
        command: "gnome-tweaks"
    },
    {
        label: ("Terminal"),
        symbolic: "utilities-terminal-symbolic",
        command: "gnome-terminal"
    }
];

var RIGHT_SIDE_SHORTCUTS = ["Home", "Documents","Downloads", "Music","Pictures","Videos","Software", 
"Settings","Tweaks", "Terminal", "Activities-Overview"];

var SOFTWARE_SHORTCUTS = ["Software", "Settings","Tweaks", "Terminal", "Activities-Overview"];

var SECTIONS = [
    'devices',
    'network',
    'bookmarks',
];

var EMPTY_STRING = '';

var SUPER_L = 'Super_L';

var SUPER_R = 'Super_R';

var HOT_KEY = { // See: org.gnome.shell.extensions.arc-menu.menu-hotkey
    Undefined: 0,
    Super_L: 1,
    Super_R: 2,
    // Inverse mapping
    0: EMPTY_STRING,  // Note: an empty string is evaluated to false
    1: SUPER_L,
    2: SUPER_R
};

var MENU_POSITION = { // See: org.gnome.shell.extensions.arc-menu.menu-position
    Left: 0,
    Center: 1,
    Right: 2
};

var MENU_LAYOUT = { // See: org.gnome.shell.extensions.arc-menu.menu-position
    Default: 0,
    Brisk: 1,
    Whisker: 2,
    GnomeMenu: 3,
    Mint: 4,
    Elementary: 5,
    GnomeDash: 6,
    Simple: 7,
    Simple2: 8,
    Redmond: 9,
    UbuntuDash: 10
};

var MENU_APPEARANCE = { // See: org.gnome.shell.extensions.arc-menu.menu-button-icon
    Icon: 0,
    Text: 1,
    Icon_Text: 2,
    Text_Icon: 3
};

var MENU_BUTTON_TEXT = { // See: org.gnome.shell.extensions.arc-menu.menu-button-text
    System: 0,
    Custom: 1
};

var MENU_BUTTON_ICON = { // See: org.gnome.shell.extensions.arc-menu.menu-button-icon
    Arc_Menu: 0,
    System: 1,
    Custom: 2
};

var MENU_ICON_PATH = {
    Arc_Menu: '/media/arc-menu-symbolic.svg'
};

var ICON_SIZES = [ 16, 24, 32, 40, 48 ];

var KEYBOARD_LOGO = {
    Path: '/media/keyboard.svg',
    Size: [256, 72] // width, height
};

var CREDITS = '\n<b>Credits:</b>'+
		'\n\nCurrent Developers'+
		'\n <a href="https://gitlab.com/LinxGem33">@LinxGem33</a>  (Founder/Maintainer)'+
		'\n<a href="https://gitlab.com/AndrewZaech">@AndrewZaech</a>  (Developer)'+
		'\n\nPast Developers'+
		'\n <a href="https://github.com/lexruee">@lexruee</a>  (Developer)'+
		'\n\n\n<b>A Special Thanks To:</b>'+
		'\n\nTranslators'+
		'\n<a href="https://gitlab.com/LinxGem33/Arc-Menu#please-refer-to-the-wiki-section-for-a-translation-guide">Full List</a>'+
		'\nPlease See Details'+
		'\n\nOther'+
		'\n<a href="https://gitlab.com/tingvarsson">@Thomas Ingvarsson</a>  (Contributor)'+
		'\n<a href="https://github.com/charlesg99">@charlesg99</a>  (Contributor)'+
		'\n<a href="https://github.com/JasonLG1979">@JasonLG1979</a>  (Contributor)'+
		'\n<a href="https://github.com/fishears/Arc-Menu">@fishears</a>  (Contributor)'+
        '\n';
        
var GNU_SOFTWARE = '<span size="small">' +
    'This program comes with absolutely no warranty.\n' +
    'See the <a href="https://gnu.org/licenses/old-licenses/gpl-2.0.html">' +
	'GNU General Public License, version 2 or later</a> for details.' +
	'</span>';

var MENU_STYLE_CHOOSER = {
    ThumbnailHeight: 200,
    ThumbnailWidth: 200,
    MaxColumns: 6,
    Styles: [
        {   thumbnail: '/media/layouts/arc-menu.svg',
            name: 'Arc Menu'
        },
        {   thumbnail: '/media/layouts/brisk-menu.svg',
            name: 'Brisk Menu Style'
        },
        {   thumbnail: '/media/layouts/whisker-menu.svg',
            name: 'Whisker Menu Style'
        },
        {   thumbnail: '/media/layouts/gnome-menu.svg',
            name: 'GNOME Menu Style'
        },
        {   thumbnail: '/media/layouts/mint-menu.svg',
            name: 'Mint Menu Style'
        },
        {   thumbnail: '/media/layouts/elementary-menu.svg',
            name: 'Elementary Menu Style'
        },
        {   thumbnail: '/media/layouts/gnome-dash-menu.svg',
            name: 'GNOME Dash Style'
        },
        {   thumbnail: '/media/layouts/simple-menu.svg',
            name: 'Simple Menu Style'
        },
        {   thumbnail: '/media/layouts/simple-menu-2.svg',
            name: 'Simple Menu 2 Style'
        },
        {   thumbnail: '/media/layouts/redmond-style-menu.svg',
            name: 'Redmond Menu Style'
        },
        {   thumbnail: '/media/layouts/ubuntu-dash-menu.svg',
            name: 'Ubuntu Dash Style'
        }   
    ]
};
    
