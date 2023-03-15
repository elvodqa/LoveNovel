

function string_percentage(str, percentage) 
    local len = string.len(str)
    local num = math.floor(len * percentage)
    return string.sub(str, 1, num) 
end
