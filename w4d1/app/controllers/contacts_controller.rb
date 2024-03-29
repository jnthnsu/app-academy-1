class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(contact_params)

    render json: @contact
  end

  def show
    @contact = Contact.find_by(id: params[:id])

    render json: @contact
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy

    render json: @contact
  end

  private

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
end
