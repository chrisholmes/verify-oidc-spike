class VerifyServiceProvider

  def initialize(base_url)
    @base_url = base_url
    @request_uri = "#{base_url}/generate-request"
    @response_uri = "#{base_url}/translate-response"
  end

  def request
    resp = HTTP["Content-Type" => "application/json"].post(@request_uri, body: {"levelOfAssurance" => "LEVEL_2"}.to_json)
    if resp.status == 200
      Request.new(JSON.parse(resp.to_s))
    else
      Error.new(resp)
    end
  end

  def handle_response(response, request_id)
    inbound_response = {
      "samlResponse" => response,
      "requestId" => request_id,
      "levelOfAssurance" => "LEVEL_2"
    }.to_json
    resp = HTTP["Content-Type" => "application/json"].post(@response_uri, body: inbound_response )
    if resp.status == 200
      Response.new(JSON.parse(resp.to_s))
    else
      Error.new(resp)
    end
  end

  class Error
    def valid?
      false
    end

    def error?
      true
    end

    def initialize(resp)
      @resp = resp
    end

    def message
      "Received a #{@resp.status} error code with body: \"#{@resp.body}\""
    end
  end

  class Request
    attr_reader :samlRequest, :requestId, :ssoLocation

    alias_method :id, :requestId

    def initialize(hash)
      @samlRequest = hash["samlRequest"]
      @requestId = hash["requestId"]
      @ssoLocation = hash["ssoLocation"]
    end

    def valid?
      true
    end

    def error?
      false
    end
  end

  class Response
    attr_reader :pid, :scenario
    def initialize(hash)
      @hash = hash
      p @hash
      @pid = hash["pid"]
      @scenario = hash["scenario"]
    end

    def error?
      false
    end

    def valid?
      @scenario == "SUCCESS_MATCH" && !pid.nil?
    end
  end
end
