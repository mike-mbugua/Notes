class ApplicationController < ActionController::API
    wrap_parameters false

# encode the payload
    def encode_token(payload)
        JWT.encode(payload, 'secret')
    end

    def auth_header
        request.headers['Authorization']
    end


    def decode_token
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, 'secret', true)
            rescue JWT::DecodeError
                nil
            end
        end
    end

# setting the current user

def current_user
    payload = decode_token
    if payload
        tenant_id = payload[0]['tenant_id']
        return Tenant.find(params[:id])
    end
    nil
end

# setting a logged in user
def logged_in?
        !!current_user
    end

# Authorization

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end