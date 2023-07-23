module PersonHelper
  def title_case(name)
    if !name
      return
    end
    words = name.split(" ")
    words = words.map { |word| word.capitalize }
    title_cased_name = words.join(" ")
    return title_cased_name
  end

  def extract_gender(gender) 
    if !gender 
        return
    end
    case gender.downcase
    when "m", "male"
        return "Male"
    when "f", "female"
        return "Female"
    when "other"
        return "Other"
    else
        "Unknown"
    end
  end
end
