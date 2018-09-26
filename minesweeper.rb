class MineSweeper
    def initialize(dimension,bomb)
        @fullmap    = []
        @usermap    = []
        @dimension  = dimension
        @bomb       = bomb

        # fill the array
        dimension.times do
            arr     = []
            arr2    = []
            dimension.times do
                arr     << 0
                arr2    << 'x'
            end
            @fullmap << arr
            @usermap << arr2
        end

        # fill the bomb
        until bomb == 0
            x       = rand(0...@dimension)
            y       = rand(0...@dimension)
            if @fullmap[x][y] != '*'
                @fullmap[x][y] = '*'
                bomb    -= 1
            end
        end

        # fill the number
        for i in 0...@dimension
            for j in 0...@dimension
                count  = 0
                if @fullmap[i][j] != '*'
                    if i != 0
                        if @fullmap[i-1][j] == '*'
                            count += 1
                        end
                        if j != 0
                            if @fullmap[i-1][j-1] == '*'
                                count += 1
                            end
                        end
                        if j < @dimension - 1
                            if @fullmap[i-1][j+1] == '*'
                                count += 1
                            end
                        end
                    end
                    if j != 0
                        if @fullmap[i][j-1] == '*'
                            count += 1
                        end
                        if i < @dimension - 1
                            if @fullmap[i+1][j-1] == '*'
                                count += 1
                            end
                        end
                    end
                    if i < @dimension - 1
                        if @fullmap[i+1][j] == '*'
                            count += 1
                        end
                        if j < @dimension - 1
                            if @fullmap[i+1][j+1] == '*'
                                count += 1
                            end
                        end
                    end
                    if j < @dimension - 1
                        if @fullmap[i][j+1] == '*'
                            count += 1
                        end
                    end
                    @fullmap[i][j]  = count
                end
            end
        end
    end # end of constructor

    def printMineSweeper # print full minesweeper board
        @fullmap.each do |item|
            item.each do |subitem|
                print "#{subitem} "
            end
            puts
            puts
        end
    end

    def printUserMap # print every user choose coordinate
        @usermap.each do |item|
            item.each do |subitem|
                print "#{subitem} "
            end
            puts
            puts
        end
    end

    def play # play the minesweeper game
        puts "Game Begin!"
        printUserMap
        flag    = true
        until flag == false
            puts "what coordinate you want to open? (x,y)"
            coord           = gets.chomp
            arr             = coord.split(",")
            x               = Integer(arr[0])
            y               = Integer(arr[1])
            @usermap[y][x]  = @fullmap[y][x]
            if @fullmap[y][x] == '*'
                flag    = false
            elsif @fullmap[y][x] == 0
                reveal(y,x)
                #do rekursif
            end
            printUserMap
            if flag == false
                puts "YOU LOSE!" 
            else
                #check if bomb size == count of "x" then win
                count = 0
                @usermap.each do |item|
                    item.each do |subitem|
                        count +=1 if subitem == 'x'
                    end
                end
                if count == @bomb
                    puts
                    printMineSweeper
                    puts "YOU WIN"
                    flag    = false
                end
            end
        end
    end

    def reveal(i,j) # reveal all empty value (0) around user choose
        if i != 0
            if @fullmap[i-1][j] == 0 && @usermap[i-1][j] != 0
                @usermap[i-1][j]    = 0
                reveal(i-1,j)
            else
                @usermap[i-1][j]    = @fullmap[i-1][j]
            end
            if j != 0
                if @fullmap[i-1][j-1] == 0 && @usermap[i-1][j-1] != 0
                    @usermap[i-1][j-1]  = 0
                    reveal(i-1,j-1)
                else
                    @usermap[i-1][j-1] = @fullmap[i-1][j-1]
                end
            end
            if j < @dimension - 1
                if @fullmap[i-1][j+1] == 0 && @usermap[i-1][j+1] != 0
                    @usermap[i-1][j+1] = 0
                    reveal(i-1,j+1)
                else
                    @usermap[i-1][j+1] = @fullmap[i-1][j+1]
                end
            end
        end
        if j != 0
            if @fullmap[i][j-1] == 0 && @usermap[i][j-1] != 0
                @usermap[i][j-1]    = 0
                reveal(i,j-1)
            else
                @usermap[i][j-1]    = @fullmap[i][j-1]
            end
            if i < @dimension - 1
                if @fullmap[i+1][j-1] == 0 && @usermap[i+1][j-1] != 0
                    @usermap[i+1][j-1]  = 0
                    reveal(i+1,j-1)
                else
                    @usermap[i+1][j-1]  = @fullmap[i+1][j-1]
                end
            end
        end
        if i < @dimension - 1
            if @fullmap[i+1][j] == 0 && @usermap[i+1][j] != 0
                @usermap[i+1][j]    = 0
                reveal(i+1,j)
            else
                @usermap[i+1][j]    = @fullmap[i+1][j]
            end
            if j < @dimension - 1
                if @fullmap[i+1][j+1] == 0 && @usermap[i+1][j+1] != 0
                    @usermap[i+1][j+1]  = 0
                    reveal(i+1,j+1)
                else
                    @usermap[i+1][j+1]  = @fullmap[i+1][j+1]
                end
            end
        end
        if j < @dimension - 1
            if @fullmap[i][j+1] == 0 && @usermap[i][j+1] == 0
                @usermap[i][j+1]    = 0
                reveal(i,j+1)
            else
                @usermap[i][j+1]    = @fullmap[i][j+1]
            end
        end
    end # end function reveal
end # end of class

puts "minesweeper dimension ? "
dimension   = Integer(gets.chomp)
puts "how many bomb ? "
bombsize    = Integer(gets.chomp)
puts

play = MineSweeper.new(dimension,bombsize)
play.printMineSweeper
play.play