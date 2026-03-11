import {
    ifApp,
    map,
    rule,
    toKey,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    switcher,
    tapModifiers,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        edit_map(),

        general_map(),

        app_finder(),
        app_browser(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "basic.to_if_held_down_threshold_milliseconds": 10,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    const numberRules = [];
    for (let i = 0; i < 10; i++) {
        const key = `${i}` as "0";

        numberRules.push(map(key, "⌘").to(key, "⌥"));
        numberRules.push(map(key, "⌥").to(key, "⌘"));
    }

    return rule("some general mappings").manipulators([
        map("left_command").to("left_command").toIfAlone("escape"),
        map("right_control").to("escape"),
        map("q", "right_option", "right_command").to$("shortcuts run 'quick quit'"),
        map("`", "left_control").to$("shortcuts run 'add reminder'"),
        map("b", "⌘⌥").to$(". /Users/suvasanketrout/dotfiles/.config/karabiner/bt_connect.sh"),

        ...numberRules,
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_browser() {
    const browsers = [
        'Chromium',
        '^net.imput.helium',
        '^app.zen-browser.zen',
        '^com.brave.Browser',
        '^com.vivaldi.Vivaldi',
        '^com.kagi.kagimacOS',
        'Safari',
    ];
    return rule("Browser", ifApp(browsers)).manipulators([
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
            // '‹⌃': toKey('s', '⌘⌃'),
        }),
    ]);
}

function edit_map() {
    const apps = [
        "com.mitchellh.ghostty",
        "org.gnu.Emacs"
    ];
    // return layer.manipulators([
    return rule("edit-mode", ifApp(apps).unless()).manipulators([
        withModifier("⌃")([
            map("b").to("←"),
            map("f").to("→"),
            map("p").to("↑"),
            map("n").to("↓"),
            map("w").to("⌫", "⌥"),
            map("u").to("⌫", "⌘"),
            withModifier("shift")([
                map("b").to("←", "⇧"),
                map("f").to("→", "⇧"),
            ])
        ]),
        withModifier("⌥")([
            map("b").to("←", "⌥"),
            map("f").to("→", "⌥"),
            map("d").to("⌦", "⌥"),
            withModifier("shift")([
                map(",").to("↑", "⌘"),
                map(".").to("↓", "⌘"),
                map("b").to("←", "⌥⇧"),
                map("f").to("→", "⌥⇧"),
            ])
        ]),
    ]);
}
