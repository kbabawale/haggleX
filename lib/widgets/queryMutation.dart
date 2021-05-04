class QueryMutation {
  String addUser() {
    return """

      mutation registerMutation(\$email:String!,\$username:String!,\$password:String!,\$phonenumber:String!,\$currency:String!,\$country:String!,\$referralCode:String!){

        register(data:{
          email:\$email,username:\$username,password:\$password,phonenumber:\$phonenumber,currency:\$currency,country:\$country,referralCode:\$referralCode
          }
          ){

          token

        }

      }

      """;
  }

  String verifyUser() {
    return """

      mutation verifyUser(\$code:Int!){

        verifyUser(data:{
          code:\$code
          }
          ){

          token

        }

      }

      """;
  }

  String login() {
    return """

      mutation login(\$input:String!,\$password:String!){

        login(data:{
          input:\$input,
          password:\$password
          }
          ){

          token

        }

      }

      """;
  }

  String resendVerificationCode() {
    return """

      query resendVerificationCode(\$email:String!){

        resendVerificationCode(data:{
          email:\$email
          }
          )

      }

      """;
  }
}
