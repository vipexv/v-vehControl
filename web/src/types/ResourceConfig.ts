export interface ResourceConfig {
  Debug: boolean;
  CommandName: string;
  Keybind: {
    enabled: boolean;
    key: string
  };
  Translation: {
    ["tip_focus_mode"]: string;
    ["tab_windows"]: string;
    ["tab_seats"]: string;
    ["tab_miscellaneous"]: string;
    ["tab_doors"]: string;
  }
}