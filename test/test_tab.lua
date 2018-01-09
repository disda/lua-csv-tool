rowContent = "0	1	1	1"
mt = {}
function RowToTable(rowContent)
    -- 修改文件名
    -- 将每行的信息读取到一个数组中，这个函数还是要修改
    -- 支持的情况更多，不能只在数据完成的情况下才能正常运行。
    local matchBeginIndex = 1
    local matchLastIndex = 1
    local strBeginIndex = 1

    local i = 1
    while true do     
        matchBeginIndex,matchLastIndex = string.find(rowContent,'\t',strBeginIndex)
        -- 此情况下是相等的
        if not matchLastIndex then 
            subStr = string.sub(rowContent,strBeginIndex,string.len(rowContent))
            if subStr ~= '' then
                mt[i] = tonumber(subStr)
            end
            return
        end 
        subStr = string.sub(rowContent,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        if subStr ~= '' and subStr ~= nil then 
            mt[i] = tonumber(subStr)
        end 
        
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end    
end

RowToTable(rowContent)

print(string.format("%d %d %d %d",mt[1],mt[2],mt[3],mt[4]) )