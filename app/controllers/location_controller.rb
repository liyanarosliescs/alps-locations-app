class LocationController < ApplicationController
  def index
  end

  def search
    countries = find_country(params[:country])
    unless countries
      flash[:alert] = 'Country not found'
      return render action: :index
    end
    @country = countries.first
  end

  private
    def request_api(url)
      response = Excon.get(
        url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(url).host,
          'X-RapidAPI-Key' => 'b96161dff7mshb182d925da53846p112014jsn556de05d046e'
        }
      )
      return nil if response.status != 200
      JSON.parse(response.body)
    end

    def find_country(name)
      request_api("https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}")
    end
end
