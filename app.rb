require 'sinatra'
require 'braintree'
require 'awesome_print'

  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = '23nd25g4kn7gnqbb'
  Braintree::Configuration.public_key = '8552x2ym5bvhsycp'
  Braintree::Configuration.private_key = '17f3279171d4fd90ee9cd5256be17abf'

  get '/' do
    @client_token = Braintree::ClientToken.generate
    erb :index
  end

  post '/process' do

    result = Braintree::Transaction.sale(
      amount: '123.45',
      payment_method_nonce: params[:payment_method_nonce]
    )

    if result.success?
      @transaction = result.transaction
      erb :process
    else
      'Payment failed'
    end

  end