=begin
Программа запрашивает у пользователя имя и рост и выводит идеальный вес
 по формуле (<рост> - 110) * 1.15, после чего выводит результат пользователю на экран
 с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка 
 "Ваш вес уже оптимальный"
=end

# Запрашиваем у пользователя его имя и рост.
puts "Определение идеального веса"

puts "Введите свое имя"
name = gets.chomp
name.capitalize!

puts "Введите свой рост"
height = gets.to_i

# Вычисляем идеальный вес и выводим результаты.
ideal_weight = (height - 110) * 1.15
if ideal_weight >= 0
  puts "#{name}, ваш идеальный вес #{ideal_weight.round(1)} кг."
else
  puts "#{name}, ваш вес уже оптимальный."
end