fibonachi_number = []
fibonachi_number[0] = 0
fibonachi_number[1] = 1
i = 1

while fibonachi_number[i] < 100 - fibonachi_number[i - 1]
  i += 1
  fibonachi_number[i] = fibonachi_number[i - 1] + fibonachi_number[i - 2]
end
puts fibonachi_number
