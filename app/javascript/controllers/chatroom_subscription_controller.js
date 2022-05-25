import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatroomId: Number }

  connect() {
    // subscribe to the chatroom channel (app/channels/chatroom_channel.rb)
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => console.log(data) }
      )
    // console.log(`I need to subscribe to the chatroom with the id ${this.chatroomIdValue}.`);
  }
}
