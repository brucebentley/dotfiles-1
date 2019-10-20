/*
 * Arc Menu: The new applications menu for Gnome 3.
 *
 * This file has been created specifically for ArcMenu under the terms of the GPLv2 licence by : 
 *
 * Original work: Copyright (C) 2019 Andrew Zaech 
 *
 * Artwork work: Copyright (C) 2017-2019 LinxGem33
 * 
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

// Import Libraries
const Me = imports.misc.extensionUtils.getCurrentExtension();

const {Clutter, GLib, Gio, GMenu, Gtk, Shell, St} = imports.gi;
const AppFavorites = imports.ui.appFavorites;
const appSys = Shell.AppSystem.get_default();
const ArcSearch = Me.imports.search;
const Constants = Me.imports.constants;
const GnomeSession = imports.misc.gnomeSession;
const Gettext = imports.gettext.domain(Me.metadata['gettext-domain']);
const Main = imports.ui.main;
const MenuLayouts = Me.imports.menulayouts;
const MW = Me.imports.menuWidgets;
const PlaceDisplay = Me.imports.placeDisplay;
const PopupMenu = imports.ui.popupMenu;
const Utils =  Me.imports.utils;
const _ = Gettext.gettext;

var modernGnome = imports.misc.config.PACKAGE_VERSION >= '3.31.9';

// Application Menu Button class (most of the menu logic is here)
var createMenu = class {
    constructor(mainButton) {
        this.button = mainButton;
        this._settings = mainButton._settings;
        this.section = mainButton.section;
        this.appMenuManager = mainButton.appMenuManager;
        this.leftClickMenu  = mainButton.leftClickMenu;
        this.currentMenu = Constants.CURRENT_MENU.FAVORITES; 
        this._applicationsButtons = [];
        this._session = new GnomeSession.SessionManager();
        this.leftClickMenu.removeAll();

        this._tree = new GMenu.Tree({ menu_basename: 'applications.menu' });
        this._treeChangedId = this._tree.connect('changed', ()=>{
            this._reload();
        });

        //LAYOUT------------------------------------------------------------------------------------------------

        
        this._firstAppItem = null;
        this._firstApp = null;
        this._tabbedOnce = false;

        this._createLeftBox();
        this._loadCategories();
        this._display(); 
        this.leftClickMenu.actor.style = 'max-height: '+(this.leftClickMenu.actor.height + 250)+'px;';
    }
    _onMainBoxKeyPress(mainBox, event) {
        return Clutter.EVENT_PROPAGATE;
    }
    setCurrentMenu(menu){
        this.currentMenu = menu;
    }
    getCurrentMenu(){
        return this.currentMenu;
    } 
    resetSearch(){ //used by back button to clear results
        this.setDefaultMenuView();  
    }
    _redisplayRightSide(){

    }
    // Redisplay the menu
    _redisplay() {
  
    }
    _reload() {
        this.leftClickMenu.removeAll()
        this._applicationsButtons = [];
        this._loadCategories();
        this._display(); 
    }
    updateStyle(){
    }
    // Display the menu
    _display() {
        this._displayCategories();           
    }
    // Load menu category data for a single category
    _loadCategory(categoryId, dir) {
        let iter = dir.iter();
        let nextType;
        while ((nextType = iter.next()) != GMenu.TreeItemType.INVALID) {
            if (nextType == GMenu.TreeItemType.ENTRY) {
                let entry = iter.get_entry();
                let id;
                try {
                    id = entry.get_desktop_file_id();
                } catch (e) {
                    continue;
                }
                let app = appSys.lookup_app(id);
                if (app && app.get_app_info().should_show())
                    this.applicationsByCategory[categoryId].push(app);
            } 
            else if (nextType == GMenu.TreeItemType.DIRECTORY) {
                let subdir = iter.get_directory();
                if (!subdir.get_is_nodisplay())
                    this._loadCategory(categoryId, subdir);
            }
        }
    }

    // Load data for all menu categories
    _loadCategories() {
        this.applicationsByCategory = {};
        this.categoryDirectories=[];

        this._tree.load_sync();
        let root = this._tree.get_root_directory();
        let iter = root.iter();
        let nextType;
        while ((nextType = iter.next()) != GMenu.TreeItemType.INVALID) {
            if (nextType == GMenu.TreeItemType.DIRECTORY) {
                let dir = iter.get_directory();                  
                if (!dir.get_is_nodisplay()) {
                    let categoryId = dir.get_menu_id();
                    this.applicationsByCategory[categoryId] = [];
                    this._loadCategory(categoryId, dir);
                    this.categoryDirectories.push(dir);  
                }
            }
        }
        this.categoryMenuItemArray=[];
        let categoryMenuItem = new MW.CategorySubMenuItem(this, "","Favorites");
        this._displayGnomeFavorites(categoryMenuItem);
        this.categoryMenuItemArray.push(categoryMenuItem);
        categoryMenuItem = new MW.CategorySubMenuItem(this, "","All Programs");
        this._displayAllApps(categoryMenuItem);
        
        this.categoryMenuItemArray.push(categoryMenuItem);
        
        for(var categoryDir of this.categoryDirectories){
            if(categoryDir){
                let categoryMenuItem = new MW.CategorySubMenuItem(this, categoryDir); 
                this.selectCategory(categoryDir,categoryMenuItem);
                this.categoryMenuItemArray.push(categoryMenuItem);    
            }
        }
        this.updateStyle();
    }
    _displayCategories(){
        this._clearApplicationsBox();
        for(let i = 0; i < this.categoryMenuItemArray.length; i++){
            this.leftClickMenu.addMenuItem(this.categoryMenuItemArray[i]);
        }
    }
    _displayGnomeFavorites(categoryMenuItem){
        let appList = AppFavorites.getAppFavorites().getFavorites();
        appList.sort(function (a, b) {
            return a.get_name().toLowerCase() > b.get_name().toLowerCase();
        });
        this._displayButtons(appList,categoryMenuItem);
        this.updateStyle(); 
    }
    // Load menu place shortcuts
    _displayPlaces() {
        
    }
    _loadFavorites() {
        
    }
    _displayFavorites() {
        
    }
    // Create the menu layout

    _createLeftBox(){
  
    }
    placesAddSeparator(id){
        
    }
    _redisplayPlaces(id) {
        
    }
    _createPlaces(id) {
        
    }
    updateIcons(){
        for(let i = 0; i<this._applicationsButtons.length;i++){
            for(let l=0;l<this._applicationsButtons[i].length;l++){
                this._applicationsButtons[i][l]._updateIcon();
            }
        }
    }
    //used to check if a shortcut should be displayed
    getShouldShowShortcut(shortcutName){
        
    }
    // Scroll to a specific button (menu item) in the applications scroll view
    scrollToButton(button) {
    
    }
    
    setDefaultMenuView(){
    
    }
    _setActiveCategory(){

        for (let i = 0; i < this.categoryMenuItemArray.length; i++) {
            let actor = this.categoryMenuItemArray[i];
            actor.setFakeActive(false);
            //actor.remove_style_class_name('active');
        }
    }
    
    // Clear the applications menu box
    _clearApplicationsBox() {
        this.leftClickMenu.removeAll();      
    }

    // Select a category or show category overview if no category specified
    selectCategory(dir,categoryMenuItem) {
        if (dir!="Frequent Apps") {
            this._displayButtons(this._listApplications(dir.get_menu_id()),categoryMenuItem);
        }
        else if(dir=="Frequent Apps") {
            this._displayButtons(this._listApplications("Frequent Apps"),categoryMenuItem);
        }
        this.updateStyle();
    }

    // Display application menu items
    _displayButtons(apps,categoryMenuItem) {
        if (apps) {
            let oldApp;
            let array = [];
            for (let i = 0; i < apps.length; i++) {
                let app = apps[i];
                if(oldApp!=app){
                    let item = new MW.ApplicationMenuItem(this, app);
                    array.push(item);
                    categoryMenuItem.menu.addMenuItem(item);	
                }
                oldApp=app;
            }
            this._applicationsButtons.push(array);
        }
    }
    _displayAllApps(categoryMenuItem){
        let appList=[];
        for(let directory in this.applicationsByCategory){
            appList = appList.concat(this.applicationsByCategory[directory]);
        }
        appList.sort(function (a, b) {
            return a.get_name().toLowerCase() > b.get_name().toLowerCase();
        });
        this._displayButtons(appList,categoryMenuItem);
        this.updateStyle(); 

    }
    // Get a list of applications for the specified category or search query
    _listApplications(category_menu_id) {
        let applist;

        // Get applications in a category or all categories
        if (category_menu_id) {
            applist = this.applicationsByCategory[category_menu_id];
        } else {
            applist = [];
            for (let directory in this.applicationsByCategory)
                applist = applist.concat(this.applicationsByCategory[directory]);
        }
        if(category_menu_id != "Frequent Apps"){
            applist.sort(function (a, b) {
                return a.get_name().toLowerCase() > b.get_name().toLowerCase();
            });
        }
        
        return applist;
    }
    destroy(){
        if (this._treeChangedId > 0) {
            this._tree.disconnect(this._treeChangedId);
            this._treeChangedId = 0;
            this._tree = null;
        }
    }
};
