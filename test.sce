//images = [
//    "C:\Users\Sanjil\Desktop\OCR\Zero.png",
//    "C:\Users\Sanjil\Desktop\OCR\One.png",
//    "C:\Users\Sanjil\Desktop\OCR\Two.png",
//    "C:\Users\Sanjil\Desktop\OCR\Three.png",
//    "C:\Users\Sanjil\Desktop\OCR\Four.png",
//    "C:\Users\Sanjil\Desktop\OCR\Five.png",
//    "C:\Users\Sanjil\Desktop\OCR\Six.png",
//    "C:\Users\Sanjil\Desktop\OCR\Seven.png",
//    "C:\Users\Sanjil\Desktop\OCR\Eight.png",
//    "C:\Users\Sanjil\Desktop\OCR\Nine.png",
//]
//
//count = zeros(10,9)
//
//for image=1:10
//    im = imread(images(image))
//    im = rgb2gray(im)
//    im = im2bw(im,0.4)
//    //imshow(im)
//    rows = size(im,"r")
//    cols = size(im,"c")
//    
//    rF = int(rows/3)
//    cF = int(cols/3)
//    
//    rDiv = [1,rF,2*rF,rows]
//    cDiv = [1,cF,2*cF,cols]
//    
//    inc = 1
//    
//    for i = 1:3
//        for j = 1:3
//            for r = rDiv(i) : rDiv(i+1)
//                for c = cDiv(j) : cDiv(j+1)
//                    if(im(r,c) == %F)
//                        count(image,inc) = count(image,inc) + 1
//                    end
//                end
//            end
//            inc = inc +1
//        end
//    end
//end
//
//disp(count)
//
//for i=1:10
//    for j=1:9
//        countr(i,j) = count(i,j)/(45*70)
//    end
//end
//
//disp(countr)
//


//actual
testImg = "C:\Users\Sanjil\Desktop\OCR\test.png"
testImg = imread(testImg)
testImg = rgb2gray(testImg)
testImg = im2bw(testImg,0.4)

//margins
flag = 0
for col = 1 : size(testImg,"c")
    for row = 1 : size(testImg, "r")
        if(testImg(row,col) == %F)
            flag = 1
            break
        end
    end
    if(flag == 1)
        break
    end
end
startCol = col

flag = 0
for col = size(testImg,"c") :-1: startCol
    for row = 1 : size(testImg, "r")
        if(testImg(row,col) == %F)
            flag = 1
            break
        end
    end
    if(flag == 1)
        break
    end
end
endCol = col

flag = 0
for row = 1 : size(testImg,"r")
    for col = startCol : endCol
        if(testImg(row,col) == %F)
            flag = 1
            break
        end
    end
    if(flag == 1)
        break
    end
end
startRow = row

flag = 0
for row = size(testImg,"r") : -1 : 1
    for col = startCol : endCol
        if(testImg(row,col) == %F)
            flag = 1
            break
        end
    end
    if(flag == 1)
        break
    end
end
endRow = row

//disp(startRow)
//disp(endRow)
//disp(startCol)
//disp(endCol)

//(count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1))))
//individual chars
chars(1) = startCol
inc = 1
blockStore = %F
for col = startCol : endCol
    isEmpty = %T
    for row = startRow : endRow
        if(testImg(row,col) == %F)
            isEmpty = %F
            if(blockStore == %T)
                inc = inc + 1
                chars(inc) = (col)
                blockStore = %F
            end
            break
        end
    end
    if(blockStore == %F && isEmpty == %T)
        inc = inc + 1
        chars(inc) = (col-1)
        blockStore = %T
    end
end

inc = inc +1 
chars(inc) = endCol

for i = 1 : inc
    disp(chars(i))
end


//recognize
rf = int((endRow - startRow)/3)
rdiv = [startRow, startRow+rf, startRow+(2*rf), endRow]
//disp(rf)
//disp(rdiv)
for i = 1: +2 :inc
    cf = int((chars(i+1)-chars(i))/3)
//    disp(cf)
    cdiv = [chars(i), chars(i)+cf, chars(i)+(2*cf), chars(i+1)]
//    disp(cdiv)
    
    //tree
    //1-4
    count = 0
    for row = rdiv(1) : rdiv(2)
        for col = cdiv(1) : cdiv(2)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if( (count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.01 )
        disp(count)
        disp("No is 4")
        continue
    end
    
    //9-7
    count = 0
    for row = rdiv(3) : rdiv(4)
        for col = cdiv(3) : cdiv(4)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if((count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.01 )
        disp(count)
        disp("No is 7")
        continue
    end
    
    //8-1,2
    count = 0
    for row = rdiv(3) : rdiv(4)
        for col = cdiv(2) : cdiv(3)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if((count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.01 )
        disp(count)
        disp("No is 1")
        continue
    elseif((count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) > 0.05)
        disp(count)
        disp("No. is 2")
        continue
    end
    
    //4-3,6
    count = 0
    for row = rdiv(2) : rdiv(3)
        for col = cdiv(1) : cdiv(2)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if((count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.01 )
        disp(count)
        disp("No is 3")
        continue
    elseif((count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) > 0.08)
        disp(count)
        disp("No. is 6")
        continue
    end
    
    //5-0
    count = 0
    for row = rdiv(2) : rdiv(3)
        for col = cdiv(2) : cdiv(3)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if( (count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.01 )
        disp(count)
        disp("No is 0")
        continue
    end
    
    //3-5
    count = 0
    for row = rdiv(1) : rdiv(2)
        for col = cdiv(3) : cdiv(4)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if( (count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) < 0.05 )
        disp(count)
        disp("No is 5")
        continue
    end
    
    //6-9,8
    count = 0
    for row = rdiv(2) : rdiv(3)
        for col = cdiv(3) : cdiv(4)
            if(testImg(row,col) == %F)
                count = count +1
            end
        end
    end
    if( (count/((rdiv(4)-rdiv(1))*(cdiv(4)-cdiv(1)))) > 0.08 )
        disp(count)
        disp("No is 9")
    else 
        disp("No. is 8")
    end
end
