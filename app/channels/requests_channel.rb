class RequestsChannel < ApplicationCable::Channel
  def follow
    stream_from 'requests'
  end
end
