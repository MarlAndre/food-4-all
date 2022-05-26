import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = [ "messages" ]

  connect() {
    // subscribe to the chatroom channel (app/channels/chatroom_channel.rb)
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
      )
      // console.log(`I need to subscribe to the chatroom with the id ${this.chatroomIdValue}.`);
    }

  #insertMessageAndScrollDown(data) {
    // Logic to know if the sender is the current_user
    const currentUser = this.currentUserIdValue === data.sender_id
    // Creating the whole message from the `data.message` String
    const messageElement = this.#buildMessageElement(currentUser, data.message)

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  #buildMessageElement(currentUser, message) {
    return `
     <div class="message-row d-flex ${this.#justifyClass(currentUser)}">
      <div class="${this.#userStyleClass(currentUser)}">
        ${message}
      </div>
    </div>
    `
  }

  #justifyClass(currentUser) {
    return currentUser ? 'justify-content-end' : 'justify-content-start'
  }

  #userStyleClass(currentUser) {
    return currentUser ? 'sender-style' : 'receiver-style'
  }

  // To reset the form after the message has been sent:
  resetForm(event) {
    event.target.reset()
  }

  // The disconnect() method is called when the controller disappears from the DOM:
  disconnect() {
    // console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe()
  }
}