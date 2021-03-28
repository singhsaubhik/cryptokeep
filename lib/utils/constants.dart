import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0A0E21);
const kScaffoldBackgroundColor = Color(0xFF0A0E21);
const kActiveCardColour = Color(0xFF1D1E33);
// const kInactiveCardColour = Color(0xFF111328);
const kInactiveCardColour = Color(0xFF1D1E33);
const kAccentColor = Color(0xFF6dd5ed);

/// Configs constants
const IS_FIRST_RUN = "isFirstRun";
const APP_CONFIGS = "cryptokeep_configs";
const USER_BOX = "cryptokeep_user_box";
const IS_USER = "IS_USER";
const MASTER_PASSWORD = "masterPassword";

/// Messages constants
const PASSWORD_COPIED = "Password copied to clipboard";
const USERNAME_COPIED = "Username copied to clipboard";
const FINGERPRINT_NOT_SUPPORTED =
    "Fingerprint Authentication is not supported on this device";

/// Configs constants
const CONFIGS = "CONFIGS";
const SETTINGS_CONFIG_BOX = "SETTINGS_CONFIG_BOX";
const CHANNEL = "com.singhsaubhik.cryptokeep/screencatpure";

const IS_DARK_THEME = "IS_DARK_THEME";
const DISABLE_SCREEN_CAPTURE = "DISABLE_SCREEN_CAPTURE";
const LOGIN_WITH_FP = "LOGIN_WITH_FP";
const CLEAR_CLIPBOARD = "CLEAR_CLIPBOARD";
const CLEAN_UP_DELAY = "CLEAN_UP_DELAY";
const DEFAULT_CONFIGS = {
  DISABLE_SCREEN_CAPTURE: true,
  IS_DARK_THEME: true,
  LOGIN_WITH_FP: false,
  CLEAR_CLIPBOARD: false,
  CLEAN_UP_DELAY: 30
};

const CLEAR_CLIPBOARD_TIMEOUT_OPTIONS = [5, 10, 30, 60, 120, 300];
