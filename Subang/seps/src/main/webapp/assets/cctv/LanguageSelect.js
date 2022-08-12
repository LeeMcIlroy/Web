var LANGID_ENGLISH              = 0;    // English (U.S.)
var LANGID_GERMAN               = 1;    // German (Standard)
var LANGID_FRENCH               = 2;    // French (Standard)
var LANGID_ITALIAN              = 3;    // Italian (Standard)
var LANGID_SPANISH              = 4;    // Spanish (Spain, International Sort)
var LANGID_KOREAN               = 5;    // Korean
var LANGID_JAPANESE             = 6;    // Japanese
var LANGID_CHINESE_TRADITIONAL  = 7;    // Chinese (Taiwan)
var LANGID_CHINESE_SIMPLIFIED   = 8;    // Chinese (RPC)
var LANGID_DANISH               = 9;    // Danish
var LANGID_DUTCH                = 10;    // Dutch (Netherlands)
var LANGID_POLISH               = 11;    // Polish
var LANGID_SWEDISH              = 12;    // Swedish
var LANGID_PORTUGUESE           = 13;    // Portuguese
var LANGID_CZECH                = 14;    // Czech
var LANGID_RUSSIAN              = 15;    // Russian
var LANGID_HUNGARIAN            = 16;    // Hungarian
var LANGID_UNITEDKINGDOM        = 17;    // UK
var LANGID_FINNISH              = 18;    // Finnish
var LANGID_TURKISH              = 19;    // Turkish
var SELECTED_LANGUAGE = LANGID_ENGLISH;

function selectedLanguage() {
    return SELECTED_LANGUAGE;
}

switch (navigator.systemLanguage)
{
    case "de":
    case "de-DE":
        SELECTED_LANGUAGE = LANGID_GERMAN;
        break;
    case "fr":
    case "fr-FR":
        SELECTED_LANGUAGE = LANGID_FRENCH;
        break;
    case "it":
    case "it-IT":
        SELECTED_LANGUAGE = LANGID_ITALIAN;
        break;
    case "es":
    case "es-ES":
        SELECTED_LANGUAGE = LANGID_SPANISH;
        break;
    case "ko":
    case "ko-KR":
        SELECTED_LANGUAGE = LANGID_KOREAN;
        break;
    case "ja":
    case "ja-JP":
        SELECTED_LANGUAGE = LANGID_JAPANESE;
        break;
    case "zh-tw":
    case "zh-TW":
        SELECTED_LANGUAGE = LANGID_CHINESE_TRADITIONAL;
        break;
    case "zh-cn":
    case "zh-CN":
        SELECTED_LANGUAGE = LANGID_CHINESE_SIMPLIFIED;
        break;
    case "da":
    case "da-DK":
        SELECTED_LANGUAGE = LANGID_DANISH;
        break;
    case "nl":
    case "nl-NL":
        SELECTED_LANGUAGE = LANGID_DUTCH;
        break;
    case "pl":
    case "pl-PL":
        SELECTED_LANGUAGE = LANGID_POLISH;
        break;
    case "sv":
    case "sv-SE":
        SELECTED_LANGUAGE = LANGID_SWEDISH;
        break;
    case "pt":
    case "pt-PT":
        SELECTED_LANGUAGE = LANGID_PORTUGUESE;
        break;
    case "cs":
    case "cs-CZ":
        SELECTED_LANGUAGE = LANGID_CZECH;
        break;
    case "ru":
    case "ru-RU":
        SELECTED_LANGUAGE = LANGID_RUSSIAN;
        break;
    case "hu":
    case "hu-HU":
        SELECTED_LANGUAGE = LANGID_HUNGARIAN;
        break;
    case "en-gb":
    case "en-GB":
        SELECTED_LANGUAGE = LANGID_UNITEDKINGDOM;
        break;
    case "fi":
    case "fi-FI":
        SELECTED_LANGUAGE = LANGID_FINNISH;
        break;
    case "tr":
    case "tr-TR":
        SELECTED_LANGUAGE = LANGID_TURKISH;
        break;
    default : 
        SELECTED_LANGUAGE = LANGID_ENGLISH;
        break;
}
