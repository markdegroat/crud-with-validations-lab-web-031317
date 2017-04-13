class Song < ActiveRecord::Base
  validates :title, presence: true
  # need to also do cannot be repeated by the same artist in the same year
  validate :check_released
  validate :check_release_year
  validates :artist_name, presence: true
  #validates :release_year, numericality: {less_than: Date.today.year}
  validate :check_release_more_than_once, on: :create



  def check_released
    errors.add(:released,"Released is not currently true or false.") unless !!released == released
  end

  def check_release_year
    if released == true
      errors.add(:release_year, "Must be entered if released is true.") unless !release_year.nil?
    end
    #binding.pry
    if release_year.to_i > Date.today.year
      errors.add(:release_year, "Must be less than the current year, because logic.")
    end
  end

  def check_release_more_than_once
    Song.where(title: title).each do |song|
      if song.release_year == release_year
        errors.add(:artist, "Can't release the same song in the same year.")
      end
    end
  end



end

#WHEN YOU GET BACK PRINT OUT THE ERRORS ON THE NEW PAGE TO SEE WHATS NOT VALIDATING
