# Create useful alias for coffez and jquery
root = this
z_ = coffez
$ = jQuery

server = "ws://88.80.185.102:9999"

runtime = new dds.runtime.Runtime()

postTopic = new dds.Topic(0,  "Post")
#, "com.acme.chat.Post")

drQos = new dds.DataReaderQos(dds.Reliability.Reliable)
dwQos = new dds.DataWriterQos(dds.Reliability.Reliable)

postReader = z_.None
postWriter = z_.None


avatar = "avatar" + Math.floor((Math.random() * 10000) + 1);


createMyPost = (post) ->
  who = post.name
  what = post.msg

  """
    <li class="left clearfix">
      <span class="chat-img pull-right">
        <img src="http://placehold.it/50/FA6F57/fff&amp;text=ME" alt="User Avatar" class="img-circle">
      </span>
      <div class="chat-body clearfix">
        <div class="header">
          <strong class="primary-font">#{who}</strong>
          <small class="pull-right text-muted">
            <span class="glyphicon glyphicon-time"></span>
              some time ago...
          </small>
        </div>
        <p>
          #{what}
        </p>
      </div>
    </li>
"""

createOtherPost = (post) ->
  who = post.name
  what = post.msg

  """
    <li class="left clearfix">
      <span class="chat-img pull-left">
        <img src="http://placehold.it/50/55C1E7/fff&amp;text=U" alt="User Avatar" class="img-circle">
      </span>
      <div class="chat-body clearfix">
        <div class="header">
          <strong class="primary-font">#{who}</strong>
          <small class="pull-right text-muted">
            <span class="glyphicon glyphicon-time"></span>
              some time ago...
          </small>
        </div>
        <p>
          #{what}
        </p>
      </div>
    </li>
"""

class Post
  constructor: (@name, @msg) ->

processPost = () ->
  msg = $("#ChatMessage").val()
  post = new Post(avatar, msg)
  postWriter.map((dw) -> dw.write(post))
  $("#ChatMessageList").append(createMyPost(post))
  $("#ChatMessage").val("")

$("#ChatMessage").keyup(
    (e) ->
      if(e.keyCode is 13) then processPost()
)


$("#SendMsgButton").click(
  (evt) ->
    console.log("Send Button has been clicked")
    processPost()
)

$("#SelectAvatarButton").click(
  (evt) ->
    s = $("#AvatarName").val()
    if (s isnt "")
      avatar = s
)


runtime.onconnect = () ->
  dr = new dds.DataReader(runtime, postTopic, drQos)
  dw = new dds.DataWriter(runtime, postTopic, dwQos)

  dr.addListener(
    (post) ->
      if (post.name isnt avatar)
        $("#ChatMessageList").append(createOtherPost(post))
  )
  postReader = z_.Some(dr)
  postWriter = z_.Some(dw)



connectRuntime = () ->
  $("#AvatarName").val(avatar)
  runtime.connect(server, "uid:pwd")






$(document).ready(
    () -> connectRuntime()

  )
