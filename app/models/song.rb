class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: :release_year,
    message: "Can't release the same song... IN THE SAME YEAR!" }
  validate :year_checker

  def year_checker
    if !self.released && self.release_year
      self.errors[:release_year] << ["That's not possible to have a release year without being released"]
    elsif self.released && !self.release_year
      self.errors[:release_year] << ["What year was it released?"]
    elsif self.released && self.release_year > Time.now.year
       self.errors[:release_year] << ["Can't have released a song in the future"]
    end
  end


end
