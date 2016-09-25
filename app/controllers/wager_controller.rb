class WagerController < ApplicationController

  def bet
    @wager = Wager.find(params[:id])
    sch = @wager.scheduled_time.split(":")
    hour = sch[0].to_i
    min = sch[1].to_i

    avg_min = min + rand(1..22)

    if avg_min > 59
      hour += 1
      avg_min -= 60
    end

    avg_min = "0" + avg_min.to_s if avg_min < 10

    avg_arrival = hour.to_s + ":" + avg_min.to_s

    last_5 = []
    5.times do
      temp_minutes = nil
      temp_hour = nil
      temp_minutes = avg_min.to_i + rand(-12..12)
      temp_hour = hour
      if temp_minutes > 59
        temp_hour += 1
        temp_minutes -= 60
      end
      temp_minutes = "0" + temp_minutes.to_s if temp_minutes < 10

      time = temp_hour.to_s + ":" + temp_minutes.to_s
      last_5 << time
    end

    @made_up_stuff = {
      avg_arrival: avg_arrival,
      last_5: last_5,
      trend: "Usually Late",
      early_payout: "1.2",
      late_payout: "0.8"
    }
    render 'wager/bet'
  end

  def bus
    render 'wager/bus'
  end

  def index
    @wagers = Wager.all
    render 'wager/index'
  end

  def get_bus
    @wager = Wager.create(bus_params);
    redirect_to "/wager/#{@wager.id}/bet"
  end

  def new
  end

  def type
  end

  def under
    # amount = params["amount"]
    # payout = params["payout"]
    # User.find(params["id"]).update(:amount => amount, :payout => payout)
    redirect_to "/wager"
  end

  def over
    redirect_to "/wager"
  end

  private

  def bus_params
    params.fetch(:wager, {}).permit!
  end

end
