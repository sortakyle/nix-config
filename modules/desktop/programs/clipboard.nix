{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    # By default, cliphist db is persited at $XDG_CACHE_HOME/cliphist/db
    # not persisting it for now, meaning all clipboard history is lost on reboot
    services.cliphist = {
      enable = true;
      allowImages = true;
    };

    services.copyq = {
      enable = true;
    };

    # Alternative to copyq, simple script using fzf
    home.packages = [
      (pkgs.writeShellScriptBin "chist" ''
        cliphist list | fzf --reverse | cliphist decode | wl-copy
      '')
    ];

    # Remove/hide the copyq desktop entry (should only run as a service + keybinding)
    xdg.desktopEntries = {
      "com.github.hluk.copyq" = {
        name = "CopyQ";
        noDisplay = true;
      };
    };

    # Wayland settings for copyq + history keybindings
    wayland.windowManager.hyprland.settings = {
      bind = [
        "$MOD, V, exec, ghostty --class=floating.ghostty --confirm-close-surface=false -e chist"
        "$MOD CTRL, V, exec, app2unit -- copyq toggle"
      ];

      windowrulev2 = [
        "float,class:copyq"
        "size 25% 80%,class:copyq"
        "move 74% 10%,class:copyq"
        "animation popout,class:copyq"
      ];
    };

    xdg.configFile."copyq/copyq.conf".text = ''
      # ============================================================================
      # General Settings
      # ============================================================================
      [General]
      plugin_priority=itemimage, itemencrypted, itemfakevim, itemnotes, itempinned, itemsync, itemtags, itemtext

      [Options]
      activate_closes=true
      activate_focuses=true
      activate_item_with_single_click=false
      activate_pastes=true
      always_on_top=true
      autocompletion=true
      autostart=false
      change_clipboard_owner_delay_ms=150
      check_clipboard=true
      check_selection=false
      clipboard_notification_lines=0
      clipboard_tab=&clipboard
      close_on_unfocus=true
      close_on_unfocus_delay_ms=500
      command_history_size=100
      confirm_exit=true
      copy_clipboard=false
      copy_selection=false
      disable_tray=false
      edit_ctrl_return=true
      editor=alacritty -e nvim -- %1
      expire_tab=0
      filter_case_insensitive=true
      filter_regular_expression=false
      hide_main_window=true
      hide_main_window_in_task_bar=false
      hide_tabs=true
      hide_toolbar=true
      hide_toolbar_labels=true
      item_data_threshold=1024
      item_popup_interval=0
      language=en
      max_process_manager_rows=1000
      maxitems=1000
      move=true
      native_menu_bar=true
      native_notifications=true
      native_tray_menu=false
      notification_horizontal_offset=10
      notification_maximum_height=100
      notification_maximum_width=300
      notification_position=3
      notification_vertical_offset=10
      number_search=false
      open_windows_on_current_screen=true
      restore_geometry=true
      row_index_from_one=true
      run_selection=true
      save_delay_ms_on_item_added=300000
      save_delay_ms_on_item_edited=1000
      save_delay_ms_on_item_modified=300000
      save_delay_ms_on_item_moved=1800000
      save_delay_ms_on_item_removed=600000
      save_filter_history=false
      save_on_app_deactivated=true
      script_paste_delay_ms=250
      show_advanced_command_settings=false
      show_simple_items=false
      show_tab_item_count=true
      style=
      tab_tree=false
      tabs=&clipboard
      text_tab_width=8
      text_wrap=true
      transparency=0
      transparency_focused=0
      tray_commands=true
      tray_images=true
      tray_item_paste=true
      tray_items=5
      tray_menu_open_on_left_click=false
      tray_tab=
      tray_tab_is_current=true
      update_clipboard_owner_delay_ms=-1
      vi=true
      window_key_press_time_ms=50
      window_paste_with_ctrl_v_regex=
      window_wait_after_raised_ms=50
      window_wait_before_raise_ms=20
      window_wait_for_modifier_released_ms=2000
      window_wait_raised_ms=150

      [Plugins]
      itemencrypted\enabled=true
      itemencrypted\encrypt_tabs=
      itemfakevim\enabled=true
      itemfakevim\really_enable=false
      itemfakevim\source_file=
      itemimage\enabled=true
      itemimage\image_editor=
      itemimage\max_image_height=240
      itemimage\max_image_width=320
      itemimage\svg_editor=
      itemnotes\enabled=true
      itemnotes\notes_at_bottom=false
      itemnotes\notes_beside=false
      itemnotes\show_tooltip=false
      itempinned\enabled=true
      itemsync\enabled=true
      itemsync\format_settings=@Invalid()
      itemsync\sync_tabs=@Invalid()
      itemtags\enabled=true
      itemtext\enabled=true
    '';
  };
}
