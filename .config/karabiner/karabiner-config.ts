import {
    duoLayer,
    hyperLayer,
    ifApp,
    map,
    mapDoubleTap,
    rule,
    toKey,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    historyNavi,
    switcher,
    tapModifiers,
    toClearNotifications,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        easy_edit(),
        system_layer(),

        general_map(),

        app_finder(),
        app_kitty(),
        app_browser(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        ...unix_mapping(),

        map("left_command").to("left_command").toIfAlone("escape"),
        map("right_control").to("escape"),
        map("j", "option").to("tab", "command"),
        map("k", "option").to("tab", "⌘⇧"),

        mapDoubleTap('↑').to('↖︎'),
        mapDoubleTap('↓').to('end'),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_kitty() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty")).manipulators([
        ...switcher(),
    ]);
}

function app_browser() {
    const browsers = [
        'Chromium',
        '^company.thebrowser.Browser',
        '^org.mozilla.com.zen.browser',
        '^com.brave.Browser',
        'Orion',
        'Safari',
    ];
    return rule("Browser", ifApp(browsers)).manipulators([
        ...switcher(),
        ...historyNavi(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        })
    ]);
}

function easy_edit() {
    let layer = duoLayer("s", "d")
    return layer.manipulators([
        withModifier("control")([
            map("h").to("⌫"),
            map("u").to("⌫" ,"‹⌘"),
            map("w").to("⌫" ,"‹⌥")
        ]),
        withModifier("??")([
            map("h").to("←"),
            map("j").to("↓"),
            map("k").to("↑"),
            map("l").to("→"),

            map("spacebar").to("‹⌥"),
            map("d").to("‹⇧"),

            map(",").to("delete_or_backspace"),
            map(".").to("⌦"),
        ])
    ]);
}

function raycast() {
    return hyperLayer('r')
        .description('HyperLayer: r')
        .leaderMode({ escape: ['escape'] })
        .notification()
        .manipulators([
            map("o").to$("open -g raycast://extensions/EvanZhouDev/raycast-gemini/askAboutScreen?arguments=%7B%22query%22%3A%22%22%7D"),
            map("a").to$("open -g raycast://extensions/joshmedeski/sesh/cmd-connect"),
            map("t").to$("open -g raycast://extensions/doist/todoist/search"),
            map("d").to$("open -g raycast://extensions/lardissone/raindrop-io/search"),
            map("j").to$("open -g raycast://extensions/thomas/downloads-manager/manage-downloads"),
            map("f").to$("open -g raycast://extensions/raycast/raycast-focus/toggle-focus-session"),
        ])
}

function system_layer() {
    return duoLayer("z", "x").manipulators([
        withModifier("??")([
            map('l').to(']', '⌥'),
            map('h').to('[', '⌥'),
            map('j').to('tab', '⌘⇧'),
            map('k').to('tab', '⌘'),
            map('spacebar').to('left_shift'),

            map("delete_or_backspace").to(toClearNotifications),
            map("\\").toSleepSystem(),

            map("]").to("volume_up"),
            map("[").to("volume_down"),
            map("p").to("mute"),
            map("o").to("vk_consumer_next"),
            map("i").to('play_or_pause'),
            map("u").to("vk_consumer_previous"),
            map("=").to("display_brightness_increment"),
            map("-").to("display_brightness_decrement"),
        ]),
    ]);
}
