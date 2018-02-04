defmodule MusehackersWeb.Api.V1.SessionView do
  use MusehackersWeb, :view
  @moduledoc false

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message: """
        You are successfully logged in!
        Add this token to authorization header to make authorized requests.
      """
    }
  end

  def render("refresh_token.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message: """
        Token was successfully re-generated!
      """
    }
  end

  def render("session_status.json", _params) do
    %{
      status: :ok
    }
  end
end
