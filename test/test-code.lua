mt = {}
for i = 1,10 do
    mt[i] = {}
    for j=1,4 do 
        mt[i][j] = 1
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
                mt[1][i] = subStr;
            end
            return
        end 
        subStr = string.sub(row,strBeginIndex,matchBeginIndex-1)
        -- print(subStr)
        if subStr ~= '' and subStr ~= nil then 
            mt[j][i] = tonumber(subStr)
        end 
        print(i,subStr,"end")
        i = i + 1
        strBeginIndex = strBeginIndex + string.len(subStr) + 1
    end    
end

rowToTable1("1,2,3,",1)
print("end")
for i=1,10 do 
    for j=1,1 do 
        -- a = string.format("%d %d %d %d",mt[i][1],mt[i][2],mt[i][3],mt[i][4])
        -- print(a)
        print(mt[i][1],mt[i][2],mt[i][3],mt[i][4])   
    end 
end 