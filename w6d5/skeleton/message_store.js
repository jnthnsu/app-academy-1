const MessageStore = {
  messages: {
    sent: [
      {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
      {to: "person@mail.com", subject: "zzz", body: "so booring"}
    ],
    inbox: [
      {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
  "Stay at home mom discovers cure for leg cramps. Doctors hate her"},
    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
    ]
  },

  getInboxMessages: function(){
    return this.messages.inbox;
  },

  getSentMessages: function(){
    return this.messages.sent;
  }
};

class Message{
  constructor(from, to, subject, body){
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.body = body;

    this.messageDraft = new Message();
  }

  updateDraftField(field, value){
    Object.defineProperty(this.messageDraft, field).set(value);
    MessageStore.sent.push(this.messageDraft);
    this.messageDraft = new Message();
  }
}

module.exports = MessageStore;
module.exports = Message;
