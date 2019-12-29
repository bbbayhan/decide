# frozen_string_literal: true

class V1::VotingsDoc < ApiDoc
  route_base 'votings'
  components do
    schema OptionSchema: [
      {
        id: String,
        title: String
      },
      dft: {}
    ]

    schema QuestionSchema: [
      {
        id: String,
        title: String,
        description: String,
        options: Array[:OptionSchema]
      },
      dft: {}
    ]

    schema VotingResponseSchema: [
      {
        id: String,
        title: String,
        description: String,
        status: String
      },
      dft: {}
    ]

    schema VotingDetailedResponseSchema: [
      {
        id: String,
        title: String,
        description: String,
        status: String,
        questions: Array[:QuestionSchema]
      },
      dft: {}
    ]

    schema VotingListSchema: [
      {
        votings: Array[:VotingResponseSchema]
      },
      dft: {}
    ]
    schema BadRequestSchema: [
      { errors: Array[String] }, dft: {}
    ]

    response NotFoundResponse: ['Not found', :json, data: {}]
    response BadRequestResponse: ['Bad request', :json, data: :BadRequestSchema]
    response VotingResponse: ['Voting', :json, data: :VotingResponseSchema]
    response VotingDetailedResponse: ['Voting', :json, data: :VotingDetailedResponseSchema]
  end

  api :index do
    response 200, 'Success', :json, data: :VotingListSchema
    header 'Accept', String, default: 'application/json'
  end

  api :show, 'Get voting', http: 'get' do
    path :id, String
    param :path, :id, String, :req, desc: 'UUID of the voting'
    header 'Accept', String, default: 'application/json'
    response_ref 202 => :VotingDetailedResponse
    response_ref 400 => :BadRequestResponse
    response_ref 404 => :NotFoundResponse
  end

  api :vote, 'Submit votes', http: 'post' do
    path :id, String
    header 'Accept', String, default: 'application/json'
    request_body :opt, :json, data: {
      'question_id' => Array['option_id']
    }
    response 201, 'Success', :json, data: {}
    response_ref 400 => :BadRequestResponse
  end
end