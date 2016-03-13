class Clothe < ActiveRecord::Base
  belongs_to :article
  belongs_to :color
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :suggestions

  def self.prase_and_add(text)
      clothes = Clothe.new
      success = false
      sieve = Stopwords::Snowball::WordSieve.new
      filtered = sieve.filter lang: :en, words: text.downcase.tr('^[a-z ]', '').split
      ori = filtered.join(" ")
      match_article = nil
      for i in 0...(filtered.length)
          if i > 1
              match_article = Article.find_by(name: "#{filtered[i-2]} #{filtered[i-1]} #{filtered[i]}")
              if !match_article.nil?
                  filtered.delete_at(i)
                  filtered.delete_at(i-1)
                  filtered.delete_at(i-2)
                  break
              end
          end

          if i > 0
              match_article = Article.find_by(name: "#{filtered[i-1]} #{filtered[i]}")
              if !match_article.nil?
                  filtered.delete_at(i)
                  filtered.delete_at(i-1)
                  break
              end
          end
          match_article = Article.find_by(name: filtered[i])
          if !match_article.nil?
              filtered.delete_at(i)
              break
          end
      end

      if match_article.nil?
          return { success: false }
      else
          clothes.article = match_article
          clothes.position = match_article.position
      end

      match_color = nil
      for i in 0...(filtered.length)
          if i > 0
              match_color = Color.find_by(name: "#{filtered[i-1]} #{filtered[i]}")
              if !match_color.nil?
                  filtered.delete_at(i)
                  filtered.delete_at(i-1)
                  break
              end
          end
          match_color = Color.find_by(name: filtered[i])
          if !match_color.nil?
              filtered.delete_at(i)
              break
          end
      end

      if match_color.nil?
          return { success: false }
      else
           clothes.color = match_color
      end


      tags = []
      filtered.each do |adj|
          if adj.present?
              tag = Tag.find_or_create_by(name: adj)
              tags << tag.name
              clothes.tags << tag
          end
      end

      clothes.raw_description = ori
      success = clothes.save
      if success
          return { success: true, color: clothes.color&.name, article: clothes.article&.name, tags: tags, id: clothes.id }
      else
          return { success: false }
      end
  end

  def self.get_random_clothes
      if [true, false, false, false].sample
          #all
          return [Clothe.where(position: 0).order("RANDOM()").first]
      else
          return [
              Clothe.where(position: 1).order("RANDOM()").first,
              Clothe.where(position: 2).order("RANDOM()").first
          ]
      end
  end

  def short_description
      if tags.empty?
          "#{color.name} #{article.name}"
      else
          "#{color.name} #{tags.map {|t| t.name}.join(' ')} #{article.name}"
      end
  end

  def self.give_suggestion(s)
      temperature = Variable.find_by(name: "temp").value.to_i
      situation = Situation.find_or_create_by(name: s)
      top_combinations = CombinationToSituation.where(situation: situation).order(score: :DESC).limit(3)

      possible_c = []
      top_combinations.each do |tc|
          if (tc.combination.articles.length == 1)
              possible_c.concat(acs.first.clothes.all.map {|e| [e]})
          else
              acs = tc.combination.articles
              le = acs.length

              acs.first.clothes.each do |kfc|
                  acs.second.clothes.each do |ksc|
                    possible_c << [kfc, ksc]
                end
            end
          end
      end

      if possible_c.empty?
          return []
      end

      high_score = -100000
      high = possible_c[0]

      possible_c.each do |c_arr|
          score = 0
          c_arr.each do |c|
              score += c.score
              score += c.color.score

              if c.article.temp_min > temperature
                  diff = (c.article.temp_min - temperature)
                  score -= diff*diff*diff*10
              elsif c.article.temp_max  < temperature
                  diff = (temperature - c.article.temp_max)
                  score -= diff*diff*diff*10
              end

              if cts = ColorToSituation.find_by(color: c.color, situation: situation)
                  score += cts.score
              else
                  score += 80
              end

              if ats = ArticleToSituation.find_by(article: c.article, situation: situation)
                  score += ats.score
              else
                  score += 80
              end

              if c.tags.empty?
                  tag_av = 150
              else
                  tag_av = 0
                  c.tags.each do |ta|
                     tag_av += ta.score
                     if tts = TagToSituation.find_by(tag: ta, situation: situation)
                         tag_av += tts.score
                     else
                         tag_av += 80
                     end
                 end
                 tag_av /= c.tags.length
             end
         end
         score /= c_arr.length
         score += rand(100)
         if score > high_score
             high = c_arr
             high_score = score
         end
     end
     return high
  end
end
