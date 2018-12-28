load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))

texts = File.read('./config/ejdic-hand-utf8.txt')
texts.each_line do |text|
  word, mean = text.split("\t")
  Text.create(word: word, mean: mean)
end
