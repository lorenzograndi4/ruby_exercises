ingredients  = [ "potatoes", "eggs", "onion", "oil", "salt" ]

family = {
  uncles: ["bob", "joe", "steve"],
  sisters: ["jane", "jill", "beth"],
  brothers: ["frank","rob","david"],
  aunts: ["mary","sally","susan"]
}

ingr_enum = ingredients.to_enum
fam_enum = family.to_enum

ingr_enum.each { |ingr| p ingr }
fam_enum.each do |relation, members|
  p "I have #{members.count} #{relation}: #{members.join(', ')}."
end