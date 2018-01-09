function GetDefaultValue(rowTable)
    defaultLine = rowTable[1]
    local matchBeginIndex = 1
    local matchLastIndex = 1
    local strBeginIndex = 1

    local i = 1
    value = {}

    while true do     
        matchBeginIndex,matchLastIndex = string.find(defaultLine,'\t',strBeginIndex)
        -- 此情况下是相等的
        if not matchLastIndex then 
            subStr = string.sub(defaultLine,strBeginIndex,string.len(defaultLine))
            if subStr ~= '' then
                value[i] = tonumber(subStr)
            end
            break
        end 
        subStr = string.sub(defaultLine,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        if subStr ~= '' and subStr ~= nil then 
            value[i] = tonumber(subStr)
        end 
        
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end 
    return value[i-1]  
end

function ToSetTableAsDefault(rowTable,defaultValue)
    -- set mt as default
    mt = {}
    for i,v in ipairs(rowTable) do 
        mt[i] = {}
        for j=1,4 do 
            mt[i][j] = defaultValue
        end 
    end 
end

function CsvToRow(filename)             
    -- 将csv文件以行为单位插入一个table中 
    local rowTable = {}
    file = io.open(filename,'r')
    for i in file:lines() do 
        table.insert(rowTable,i)
    end 
    table.remove(rowTable,1)                -- 删除第一行
    return rowTable
end 


function GetNumRow(rowTable,i)     
    -- 获取csv文件的第i行
    return rowTable[i]
end 

function RowToTable(rowContent,row)
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
                mt[row][i] = tonumber(subStr)
            end
            return
        end 
        subStr = string.sub(rowContent,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        if subStr ~= '' and subStr ~= nil then 
            mt[row][i] = tonumber(subStr)
        end 
        
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end    
end


function CsvToTable(rowTable)
    -- 将所有行table转为每列都有信息
    for j,v in ipairs(rowTable) do
        RowToTable(v,j)
    end
end

function GetCountOfRow(rowTable)
    local count = 0 
    for i,v in ipairs(rowTable) do 
        count = count + 1
    end
    return count
end


function ShowDetailTable(rowTable)
    local count = GetCountOfRow(rowTable)
    for i=1,count do
        for j=1,1 do 
            print(mt[i][1],mt[i][2],mt[i][3],mt[i][4])           
        end  
    end
end


function checkContent(rowTable)
    file = io.open("./log/tab.log","w")

    local count = GetCountOfRow(rowTable)
    for i=1,count do
        for j=1,1 do 
            if mt[i][3] < 0 or mt[i][4] < 0 then 
                -- print(string.format("%s line:%d is error,the price is less than 0",os.date("%c"),i))
                file:write(string.format("%s line:%d is error,the price is less than 0\n",os.date("%c"),i))
            elseif mt[i][3] < mt[i][4] then 
                -- print(string.format("%s line:%d is error,npc is error",os.date("%c"),i))
                file:write(string.format("%s line:%d is error,npc is error\n",os.date("%c"),i))
            end           
        end  
    end
    file:close()
end


function main()
    TableOfRow = CsvToRow("./data/my.tab")             -- table只是一个一维的table
    defaultValue = GetDefaultValue(TableOfRow)
    ToSetTableAsDefault(TableOfRow,defaultValue)       -- 定义数组，并且将值设置为default，mt这个矩阵
    CsvToTable(TableOfRow)
    
    
    checkContent(TableOfRow)
    -- ShowDetailTable(TableOfRow)
end
    

main()


-- 修改 文件格式          √
-- 日志添加时间           √   
-- 从文件中获得defalue值  √