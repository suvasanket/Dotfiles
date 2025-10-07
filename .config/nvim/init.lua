local suggestions = {
    "apple", "apricot", "avocado",
    "banana", "blueberry", "blackberry",
    "cherry", "coconut", "cranberry",
    "date", "dragonfruit", "durian",
}

_G.MyFruitCompletion = function(arglead)
    local filtered_suggestions = {}

    for _, item in ipairs(suggestions) do
        if item:lower():find('^' .. arglead:lower()) then
            table.insert(filtered_suggestions, item)
        end
    end

    return filtered_suggestions
end
require("core")
