basket    = {}
summa       = 0
final_summa = 0

loop do
  puts 'Введите название товара или stop для выхода'
  product_name = gets.chomp
  break if product_name.downcase == 'stop'

  puts 'Введите стоимость товара'
  price = gets.chomp.to_f

  puts 'Введите количество товара'
  count = gets.chomp.to_f

  basket[product_name]  = { price => count }
end
  
puts "Корзина: #{basket}"
puts "Товары на сумму:"
basket.each do |name, data|
   data.each do|price, count|
   summa =  price * count
   puts "#{name}: #{summa}"
   final_summa += summa
   end   
end
puts "Итого: #{final_summa}"
