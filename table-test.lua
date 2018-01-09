-- mt = {}
-- for i = 1,10 do
--     mt[i] = {}
--     for j=1,4 do 
--         mt[i][j] = 1
--     end 
-- end 

-- for i=1,10 do 
--     for j=1,1 do 
--         a = string.format("%d %d %d %d",mt[i][1],mt[i][2],mt[i][3],mt[i][4])
--         print(a)
--     end 
-- end 

function ToSetTableAsDefault(rowTable)
    -- set mt as default
    mt = {}
    for i,v in ipairs(rowTable) do 
        mt[i] = {}
        for j=1,4 do 
            mt[i][j] = 1
        end 
    end 
end



function CsvToRow(filename)             
    -- 将csv文件以行为单位插入一个table中 
    local rowTable = {}
    file = io.open(filename,'r')
    for i in file:lines() do 
        table.insert(rowTable,i)
        -- print(i)
    end 
    return rowTable
end 



-- for i,v in pairs(CsvToRow("./my.csv")) do
--     print(v)
-- end

function GetNumRow(rowTable,i)     
    -- 获取csv文件的第i行
    -- print(rowTable[i])
    return rowTable[i]
end 

-- GetNumRow(CsvToRow("./my.csv"),3)    --  获取csv文件中的第三行

function rowToTable(row,j)
    -- 将每行的信息读取到一个数组中，这个函数还是带修改
    local matchBeginIndex = 1
    local matchLastIndex = 1
    local strBeginIndex = 1

    local i = 1
    while true do     
        matchBeginIndex,matchLastIndex = string.find(row,',',strBeginIndex)
        -- 此情况下是相等的
        if not matchLastIndex then 
            mt[j][i] = string.sub(row,strBeginIndex,string.len(row))
            -- print(mt[1][i])
            return
        end 
        subStr = string.sub(row,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        mt[j][i] = tonumber(subStr)
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end    
end

function rowToTable1(row,j)
    -- 将每行的信息读取到一个数组中，这个函数还是要修改
    -- 支持的情况更多，不能只在数据完成的情况下才能正常运行。
    local matchBeginIndex = 1
    local matchLastIndex = 1
    local strBeginIndex = 1

    local i = 1
    while true do     
        matchBeginIndex,matchLastIndex = string.find(row,',',strBeginIndex)
        -- 此情况下是相等的
        if not matchLastIndex then 
            subStr = string.sub(row,strBeginIndex,string.len(row))
            if subStr ~= '' then
                mt[j][i] = tonumber(subStr)
            end
            -- print(mt[1][i])
            return
        end 
        subStr = string.sub(row,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        if subStr ~= '' and subStr ~= nil then 
            mt[j][i] = tonumber(subStr)
        end 
        
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end    
end


function CsvToTable(rowTable)
    -- 将所有行table转为每列都有信息
    for j,v in ipairs(rowTable) do
        rowToTable1(v,j)
    end
end

function GetCountOfRow(rowTable)
    local count = 0 
    for i,v in ipairs(rowTable) do 
        count = count + 1
    end
    return count
end

-- CsvToTable(CsvToRow("./my.csv"))             -- 接口（1）
-- CsvToTable(test)

function ShowDetailTable(rowTable)
    local count = GetCountOfRow(rowTable)
    for i=1,count do
        for j=1,1 do 
            -- a = string.format("%d %d %d %d",mt[i][1],mt[i][2],mt[i][3],mt[i][4])
            -- print(a)
            print(mt[i][1],mt[i][2],mt[i][3],mt[i][4])           
        end  
    end
end

-- function checkOneRow(rowTable,j)
--     print(rowTable[j][1],rowTable[j][2],rowTable[j][3],rowTable[j][4])           
--     if rowTable[j][3] < 0 or rowTable[j][4] < 0 then 
--         error = string.format("第%d行出错了",j)
--         print(error)
--     end
-- end  

-- function checkAllRow(ta)
--     -- 将所有行table转为每列都有信息
--     for j,v in ipairs(ta) do
--         checkOneRow(v,j)
--     end
-- end

function checkContent(rowTable)
    file = io.open("tab.log","a")

    local count = GetCountOfRow(rowTable)
    for i=1,count do
        for j=1,1 do 
            -- a = string.format("%d %d %d %d",mt[i][1],mt[i][2],mt[i][3],mt[i][4])
            -- print(a)
            -- print(type(mt[i][1]),type(mt[i][2]),type(mt[i][3]),type(mt[i][4]))
            if mt[i][3] < 0 or mt[i][4] < 0 then 
                print(string.format("%s:line:%d is error,the price is less than 0",GetNumRow(rowTable,i),i))
                file:write(string.format("%s:line:%d is error,the price is less than 0\n",GetNumRow(rowTable,i),i))
            elseif mt[i][3] < mt[i][4] then 
                print(string.format("%s:line:%d is error,npc is error",GetNumRow(rowTable,i),i))
                file:write(string.format("%s:line:%d is error,npc is error\n",GetNumRow(rowTable,i),i))
            end           
        end  
    end
    file:close()
end


function main()
    TableOfRow = CsvToRow("./my.csv")
    ToSetTableAsDefault(TableOfRow)       -- 定义数组，并且将值设置为default，mt这个矩阵
    CsvToTable(TableOfRow) 
    checkContent(TableOfRow)
    -- ShowDetailTable(TableOfRow)
end
    

main()