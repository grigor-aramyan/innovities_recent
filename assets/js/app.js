// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import socket from "./socket"
import Elm from './main';

const elmDiv = document.querySelector('#elm_target');
let backImage;
let firebaseStorage;
let postMediaFileData = { filename: "", file: null }
let ideaVideoFileData = { filename: "", file: null }
let ideaPicsList = []
let settingsPictureData = { filename: "", file: null }
let orgSettingsPictureData = { filename: "", file: null }
let notifsFetchIntervalId;

let messagingChannel = socket.channel("messaging:general", {})


if (elmDiv) {
  const app = Elm.Main.embed(elmDiv);

  window.onload = function() {
    if (document.getElementById('video')) {
      initIdeaMediaBtns();
    }

    if (document.getElementById('files')) {
      initPostMediaBtn();
    }

    if (document.getElementById('innovator-pic')) {
      initSettingsMediaBtn();
    }

    if (document.getElementById('organization-pic')) {
      initOrgSettingsMediaBtn();
    }

    restoreCachedData();

  };

  // Data caching
  app.ports.cacheAllData.subscribe(function(data) {
    localStorage.setItem("data", JSON.stringify(data));
  });

  app.ports.clearCachedData.subscribe(function() {
    localStorage.clear();
  });

  function restoreCachedData() {
    const cachedData = JSON.parse(localStorage.getItem("data"));
    if(cachedData != null) {
      app.ports.fetchCachedDataResponse.send(cachedData);

      const baseUri = 'http://localhost:4000';

      const href = window.location.href;
      if ((href == baseUri + "/#dashboard") ||
          (href == baseUri + "/#profile")) {
        setWhiteBackgroundFunction();
      }
    }
  }

  //****************************
  //****************************
  // Messaging

  messagingChannel.on("tst_event", payload => {
    console.log("Message: " + payload.msg);
  })

  messagingChannel.on("error_marking_incoming_message_as_red", payload => {
    console.log("Mark incoming message as red error: " + payload.error);
  });

  messagingChannel.on("success_marking_incoming_message_as_red", payload => {
    console.log("Mark incoming message as red sucess!");
  });

  messagingChannel.on("error_marking_message_as_red", payload => {
    console.log("Mark message as red error: " + payload.error);
  });

  messagingChannel.on("success_marking_message_as_red", payload => {
    app.ports.replyToMarkAsRedWithSendersData.send(payload);
  });

  messagingChannel.on("reply_with_message_senders_picture", payload => {
    app.ports.replyWithUnredChatMessageWithPic.send(payload);
  });

  messagingChannel.on("new_chat_message_submitted", payload => {
    app.ports.incomingChatMessage.send(payload);
  });

  messagingChannel.on("new_chat_message_error", payload => {
    const o = {uri: "", error: payload.error};
    app.ports.chatMessageSubmitError.send(o);
  });

  messagingChannel.join()
    .receive("ok", resp => {
      console.log("Messaging channel joined successfully", resp);
  })
    .receive("error", resp => { console.log("Messaging channel unable to join", resp) })

  //***************************
  //***************************


  function initIdeaMediaBtns() {
    const ideaAttachVideoBtn = document.getElementById('video');
    const ideaAttachPicsBtn = document.getElementById('pictures');


    ideaAttachPicsBtn.addEventListener('change', function(e) {
      const f = e.target.files[0];
      // letter.png
      const fileName = f.name;

      const extension = fileName.split(".")[1].toLowerCase();

      if ((extension != "png") && (extension != "jpg") && (extension != "jpeg")) {

        const output = {
          fileName: "",
          error: "Only png, jpg, jpeg allowed!"
        };

        app.ports.getIdeaPicName.send(output);
      } else {

        const output = {
          fileName: fileName,
          error: ""
        };

        let data = { filename: fileName, file: f };
        ideaPicsList.push(data);

        app.ports.getIdeaPicName.send(output);
      }

    });


    ideaAttachVideoBtn.addEventListener('change', function(e) {
      const f = e.target.files[0];
      // letter.png
      const fileName = f.name;

      const extension = fileName.split(".")[1].toLowerCase();

      if ((extension != "flv") && (extension != "mov") && (extension != "avi")
        && (extension != "wmv") && (extension != "mp4")) {

        const output = {
          fileName: "",
          error: "Only flv, mov, avi, wmv, mp4 allowed!"
        };

        app.ports.getIdeaVideoName.send(output);
      } else {

        const output = {
          fileName: fileName,
          error: ""
        };

        ideaVideoFileData.filename = fileName;
        ideaVideoFileData.file = f;

        app.ports.getIdeaVideoName.send(output);
      }

    });
  };

  function initPostMediaBtn() {
    const tmpBtn = document.getElementById('files');

    tmpBtn.addEventListener('change', function(e) {
      const f = e.target.files[0];
      // letter.png
      const fileName = f.name;

      const extension = fileName.split(".")[1].toLowerCase();

      if ((extension != "png") && (extension != "jpg") && (extension != "jpeg") && (extension != "flv") &&
        (extension != "mov") && (extension != "avi") && (extension != "wmv") && (extension != "mp4")) {

        const output = {
          fileName: "",
          error: "Only png, jpg, jpeg, flv, mov, avi, wmv, mp4 allowed!"
        };

        app.ports.getPostImageName.send(output);
      } else {

        const output = {
          fileName: fileName,
          error: ""
        };

        postMediaFileData.filename = fileName;
        postMediaFileData.file = f;

        app.ports.getPostImageName.send(output);
      }

    });
  };

  function initSettingsMediaBtn() {
    const tmpBtn = document.getElementById('innovator-pic');

    if (tmpBtn) {
      tmpBtn.addEventListener('change', function(e) {
        const f = e.target.files[0];
        // letter.png
        const fileName = f.name;

        const extension = fileName.split(".")[1].toLowerCase();

        if ((extension != "png") && (extension != "jpg") && (extension != "jpeg")) {

          const output = {
            fileName: "",
            error: "Only png, jpg, jpeg allowed!"
          };

          app.ports.getSettingsImageName.send(output);
        } else {

          const output = {
            fileName: fileName,
            error: ""
          };

          settingsPictureData.filename = fileName;
          settingsPictureData.file = f;

          app.ports.getSettingsImageName.send(output);
        }

      });
    }

  };

  function initOrgSettingsMediaBtn() {
    const tmpBtn = document.getElementById('organization-pic');

    if (tmpBtn) {
      tmpBtn.addEventListener('change', function(e) {
        const f = e.target.files[0];
        // letter.png
        const fileName = f.name;

        const extension = fileName.split(".")[1].toLowerCase();

        if ((extension != "png") && (extension != "jpg") && (extension != "jpeg")) {

          const output = {
            fileName: "",
            error: "Only png, jpg, jpeg allowed!"
          };

          app.ports.getOrgSettingsImageName.send(output);
        } else {

          const output = {
            fileName: fileName,
            error: ""
          };

          orgSettingsPictureData.filename = fileName;
          orgSettingsPictureData.file = f;

          app.ports.getOrgSettingsImageName.send(output);
        }

      });
    }
  };

  app.ports.initOrgSettingsMediaBtn.subscribe(function() {
    initOrgSettingsMediaBtn();
  });

  app.ports.initSettingsMediaBtn.subscribe(function() {
    initSettingsMediaBtn();
  });

  app.ports.initPostMediaBtn.subscribe(function() {
    initPostMediaBtn();
  });

  app.ports.initIdeaMediaBtns.subscribe(function() {
    initIdeaMediaBtns();
  });

  app.ports.markIncomingMessageAsRed.subscribe(function(messageIdWithToken) {
    messagingChannel.push("mark_incoming_message_as_red", messageIdWithToken);
  });

  app.ports.markAsRedChatMessage.subscribe(function(markMessageAsRedData) {
    messagingChannel.push("mark_chat_message_as_red", markMessageAsRedData);
  });

  app.ports.fetchMessageSenderPicture.subscribe(function(data) {
    messagingChannel.push("fetch_message_senders_picture", data);
  });

  app.ports.submitChatMessageToChannel.subscribe(function(data) {
    messagingChannel.push("new_chat_message", data);
  });

  app.ports.scrollToElement.subscribe(function(id) {
    const elem = document.getElementById(id);
    elem.scrollIntoView();
  });

  app.ports.initFakeInterOpForLocationSwitch.subscribe(function(pathString) {
    setTimeout(function() {
      app.ports.sendFakeInterOpResponseForLocationSwitch.send(pathString);
    }, 300);
  });

  app.ports.initFakeInterOp3.subscribe(function() {
    setTimeout(function() {
      app.ports.sendFakeInterOpResponse3.send("");
    }, 3000);
  });

  app.ports.initFakeInterOp2.subscribe(function() {
    setTimeout(function() {
      app.ports.sendFakeInterOpResponse2.send("");
    }, 3000);
  });

  app.ports.initFakeInterOp.subscribe(function() {
    setTimeout(function() {
      app.ports.sendFakeInterOpResponse.send("");
    }, 3000);
  });

  app.ports.turnOffNewNotifsFetch.subscribe(function() {
    if (notifsFetchIntervalId != null && notifsFetchIntervalId != undefined) {
      clearInterval(notifsFetchIntervalId);
    }
  });

  app.ports.turnOnNewNotifsFetch.subscribe(function() {
    notifsFetchIntervalId =
      setInterval(function() {
      app.ports.regularNewNotifsFetch.send("");
    }, 1000 * 60 * 3);
  });

  app.ports.sharePostOnFacebook.subscribe(function(postText) {
    FB.ui({
      method: 'share',
      quote : postText,
      href: 'https://www.innovities.com/',
    }, function(response){
      if (response.error_message == undefined) {
        console.log('success');
      } else {
        console.log('error msg: ' + response.error_message);
      }
    });
  });

  app.ports.shareProfileOnFacebook.subscribe(function(profileInfo) {
    FB.ui({
      method: 'share',
      quote : profileInfo,
      href: 'https://www.innovities.com/',
    }, function(response){
      if (response.error_message == undefined) {
        console.log('success');
      } else {
        console.log('error msg: ' + response.error_message);
      }
    });
  });

  app.ports.submitOrgSettingsPicToFirebase.subscribe(function(filename) {

    if (filename == orgSettingsPictureData.filename) {
      if (firebaseStorage == null) {
        firebaseStorage = firebase.storage();
      }

      const storageRef = firebaseStorage.ref();
      const mediaRef = storageRef.child('media/' + new Date().getTime() + '_' + orgSettingsPictureData.filename);

      const uploadTask = mediaRef.put(orgSettingsPictureData.file);

      uploadTask.on('state_changed', function(snapshot) {

      }, function(error) {

        const o = { uri: "", error: "Couldn't upload file! Refresh the page and try again, please." }
        app.ports.replyWithOrgSettingsPicUri.send(o);

      }, function() {
        uploadTask.snapshot.ref.getDownloadURL().then(function(uri) {

          const o = { uri: uri, error: "" }
          app.ports.replyWithOrgSettingsPicUri.send(o);

        });
      });
    } else {

      const o = { uri: "", error: "Something went wrong! Refresh the page and try again, please." }
      app.ports.replyWithOrgSettingsPicUri.send(o);

    }

  });

  app.ports.submitSettingsPicToFirebase.subscribe(function(filename) {

    if (filename == settingsPictureData.filename) {
      if (firebaseStorage == null) {
        firebaseStorage = firebase.storage();
      }

      const storageRef = firebaseStorage.ref();
      const mediaRef = storageRef.child('media/' + new Date().getTime() + '_' + settingsPictureData.filename);

      const uploadTask = mediaRef.put(settingsPictureData.file);

      uploadTask.on('state_changed', function(snapshot) {

      }, function(error) {

        const o = { uri: "", error: "Couldn't upload file! Refresh the page and try again, please." }
        app.ports.replyWithSettingsPicUri.send(o);

      }, function() {
        uploadTask.snapshot.ref.getDownloadURL().then(function(uri) {

          const o = { uri: uri, error: "" }
          app.ports.replyWithSettingsPicUri.send(o);

        });
      });
    } else {

      const o = { uri: "", error: "Something went wrong! Refresh the page and try again, please." }
      app.ports.replyWithSettingsPicUri.send(o);

    }

  });


  app.ports.submitPicturesToFirebase.subscribe(function(pictureNames) {
    if (firebaseStorage == null) {
      firebaseStorage = firebase.storage();
    }
    const storageRef = firebaseStorage.ref();

    // pictureNames = "letter.png, h_head.jpeg, "
    const names = pictureNames.split(", ");

    function uploadPicToFB(name, tail, uris, errors) {

      if (name == "") {
        const u = uris.reduce(function(acc, elem) {
          return (acc + ":::" + elem);
        });

        const o = { uri: u, error: "" };
        app.ports.replyWithIdeaPictureUris.send(o);
      } else {
        ideaPicsList.forEach(function({filename, file}) {
          if ((name != filename)) {
            return;
          } else {

            const mediaRef = storageRef.child('media/' + new Date().getTime() + '_' + filename);
            const uploadTask = mediaRef.put(file);

            uploadTask.on('state_changed', function(snapshot) {

            }, function(error) {

              errors = "Couldn't upload file! Refresh the page and try again, please.";

              const o = { uri: "", error: errors };
              app.ports.replyWithIdeaPictureUris.send(o);

            }, function() {
              uploadTask.snapshot.ref.getDownloadURL().then(function(uri) {
                uris.push(uri);
                uploadPicToFB(tail.slice(0,1)[0], tail.slice(1), uris, errors);
              });
            });
          }
        });
      }
    }

    uploadPicToFB(names.slice(0,1)[0], names.slice(1), [], "");
  });

  app.ports.submitVideoFileToFirebase.subscribe(function(filename) {

    if (filename == ideaVideoFileData.filename) {
      if (firebaseStorage == null) {
        firebaseStorage = firebase.storage();
      }

      const storageRef = firebaseStorage.ref();
      const mediaRef = storageRef.child('media/' + new Date().getTime() + '_' + ideaVideoFileData.filename);

      const uploadTask = mediaRef.put(ideaVideoFileData.file);

      uploadTask.on('state_changed', function(snapshot) {

      }, function(error) {

        const o = { uri: "", error: "Couldn't upload file! Refresh the page and try again, please." }
        app.ports.replyWithIdeaVideoFileUri.send(o);

      }, function() {
        uploadTask.snapshot.ref.getDownloadURL().then(function(uri) {

          const o = { uri: uri, error: "" }
          app.ports.replyWithIdeaVideoFileUri.send(o);

        });
      });
    } else {

      const o = { uri: "", error: "Something went wrong! Refresh the page and try again, please." }
      app.ports.replyWithIdeaVideoFileUri.send(o);

    }

  });


  app.ports.submitMediaFileToFirebase.subscribe(function(filename) {

    if (filename == postMediaFileData.filename) {
      if (firebaseStorage == null) {
        firebaseStorage = firebase.storage();
      }

      const storageRef = firebaseStorage.ref();
      const mediaRef = storageRef.child('media/' + new Date().getTime() + '_' + postMediaFileData.filename);

      const uploadTask = mediaRef.put(postMediaFileData.file);

      uploadTask.on('state_changed', function(snapshot) {

      }, function(error) {

        const o = { uri: "", error: "Couldn't upload file! Refresh the page and try again, please." }
        app.ports.replyWithPostMediaFileUri.send(o);

      }, function() {
        uploadTask.snapshot.ref.getDownloadURL().then(function(uri) {

          const o = { uri: uri, error: "" }
          app.ports.replyWithPostMediaFileUri.send(o);

        });
      });
    } else {

      const o = { uri: "", error: "Something went wrong! Refresh the page and try again, please." }
      app.ports.replyWithPostMediaFileUri.send(o);

    }

  });

  app.ports.reverseBackgroundImage.subscribe(function() {
    const elements = document.getElementsByClassName('jumbotron');
    for(let i = 0; i < elements.length; i++) {

      elements[i].style.backgroundColor = 'none';
      elements[i].style.backgroundImage = backImage;

    }
  })

  app.ports.setWhiteBackground.subscribe(function() {
    setWhiteBackgroundFunction();
  })

  function setWhiteBackgroundFunction() {
    const elements = document.getElementsByClassName('jumbotron');
    for(let i = 0; i < elements.length; i++) {

      elements[i].style.backgroundColor = 'white';
      const style = getComputedStyle(elements[i]);
      backImage = style.backgroundImage;
      elements[i].style.backgroundImage = 'none';

    }
  }

  app.ports.showNDAConfirmDialog.subscribe(function(data) {
    const dd = new Date();
    const month = dd.getMonth() + 1;
    const date = `${dd.getDate()}.${month}.${dd.getFullYear()}`

    const companyName = data.companyName;

    const innovatorName = data.innovatorName;
    const ideaName = data.ideaName;

    const customNda = data.customNda;

    // "arm", "eng"
    const lang = data.langString

    const DEFAULT_NDA = 'default_nda';
    const CUSTOM_NDA = 'custom_nda';

    if (customNda == "") {
      if (lang == "arm") {
        UIkit.modal.confirm('<div style"width:100%;"><h3 style="text-align:center;">ՏԵՂԵԿՈՒԹՅՈՒՆՆԵՐԻ ՉԲԱՑԱՀԱՅՏՄԱՆ ՄԱՍԻՆ ՀԱՄԱՁԱՅՆՈՒԹՅՈՒՆ</h3><p style="font-size:110%;color:black;margin-top:-1em;text-align:right;">' + date + 'թ</p><p style="font-size:110%;color:black;margin-top:-1em;">Սույն Տեղեկությունների Չբացահայտման Մասին Համաձայնությունը (այսուհետ՝ «Համաձայնություն») ուժի մեջ է մտնում ' + companyName + ' կազմակերպության և ' + innovatorName + ' գաղափար տրամադրողի միջև:</p><p style="font-size:110%;color:black;margin-top:-1em;">Սույնով ' + companyName + ' կազմակերպությունը հայտնում է իր համաձայնությունը առ այն, որ  www.innovities.com կայքում արտացոլված ' + ideaName + ' գաղափարը և դրա մանրամասները իր կողմից չեն բացահայտվի և/կամ տրամադրվի այլ անձանց, եթե գաղափար տրամադրողը չի վճարվում ' + companyName + ' կազմակերպության կողմից:</p><p style="font-size:110%;color:black;margin-top:-1em;">Վերոնշյալ սահմանափակումները չեն վերաբերվում այն տվյալներին, որոնք</p><ul style="color:black;"><li>դրանց բացահայտման պահին հայտնի են եղել հասարակայնությանը կամ հայտնի կդառնան առանց իմ միջամտության,</li><li>օգտագործվում են կամ բացահայտվում են համապատասխան տեղեկատվությունը օրինական հիմքերով տնօրինող անձանց կողմից և/կամ վերջիններիս համաձայնությամբ,</li><li>կամ բացահայտվել են պետական մարմնի համապատասխան իրավական ակտով կամ պահանջով</li><li>կամ որոնք բացահայտվել են իմ կողմից, պայմանով որ դրանք ինձ հայտնի են դարձել դրանց բացահայտման իրավունքն ունեցող որևէ երրորդ անձից, որի նկատմամբ ես չունեմ գաղտնիության պահպանման պարտավորություն:</li></ul><p style="font-size:110%;color:black;margin-top:-1em;">Սույնով ընդունում եմ, որ իմ կողմից սույն համաձայնությամբ նշված սահմանափակումների խախտման դեպքում ես պատասխանատու եմ խախտման հետևանքով համապատասխան անձանց պատճառված վնասների համար:</p><p style="font-size:110%;color:black;margin-top:-1em;">Սույն համաձայնությունն ուժի մեջ է մտնում ստորագրման պահից:</p><br /><p style="font-size:110%;color:black;margin-top:-1em;">Ստորագրություն`</p><p style="font-style:italic;font-size:110%;color:black;margin-top:-1em;">' + companyName + '</p></div>')
          .then(function() {
            app.ports.ndaAccepted.send(DEFAULT_NDA);
          }, function() {
            app.ports.ndaRejected.send("");
          });
      } else if (lang == "eng") {
        UIkit.modal.confirm('<div style="width:100%;"><h3 style="text-align:center;">NONDISCLOSURE AGREEMENT</h3><p style="font-size:110%;color:black;margin-top:-1em;text-align:right;">' + date + '</p><p style="font-size:110%;color:black;margin-top:-1em;">This Nondisclosure Agreement (the "Agreement") is entered into force by and between the ' + companyName + ' company and ' + innovatorName + ' idea provider.</p><p style="font-size:110%;color:black;margin-top:-1em;">The ' + companyName + ' company hereby express its consent not to disclose and / or provide to other parties the reflected ' + ideaName + ' idea and its details ptovided in www.innovities.com website, if the idea provider is not paid for it by the ' + companyName + ' company.</p><p style="font-size:110%;color:black;margin-top:-1em;">The above restrictions do not apply to the data which were</p><ul style="color:black;"><li>known at the time of disclosure or become known to the public without my intervention,</li><li>used or disclosed by the owners of the relevant information and/or with their consent,</li><li>disclosed by the relevant public authority regulation or requirement,</li><li>disclosed by me in case if I have become aware of the information by third party with whom I have no obligation of confidentiality.</li></ul><p style="font-size:110%;color:black;margin-top:-1em;">I am aware that in case of violation of the above mentioned limitations, I would be responsible for the damages to the relevant persons caused as a result of such violation.</p><p style="font-size:110%;color:black;margin-top:-1em;">This agreement shall enter into force upon signature.</p><br /><p style="font-size:110%;color:black;margin-top:-1em;">Signature:</p><p style="font-style:italic;font-size:110%;color:black;margin-top:-1em;">' + companyName + '</p></div>')
          .then(function() {
            app.ports.ndaAccepted.send(DEFAULT_NDA);
          }, function() {
            app.ports.ndaRejected.send("");
          });
      }
    } else {
      UIkit.modal.confirm('<div style="width:100%;"><p style="font-size:110%;color:black;margin-top:-1em;">' + customNda + '</p></div>')
        .then(function() {
          app.ports.ndaAccepted.send(CUSTOM_NDA);
        }, function() {
          app.ports.ndaRejected.send("");
        });
    }
  });

  app.ports.showPromoRegistrationConfirmDialog.subscribe(function() {
    UIkit.modal.dialog('<div class="responsiveWidth uk-modal-body"><h3 style="text-align:center;color:skyblue;">ՇՆՈՐՀԱԿԱԼՈւԹՅՈւՆ՝</h3><p style="font-size:110%;color:black;margin-top:-1em;text-align:center;">մեր հարթակում գրանցվելու համար: Մենք լրացուցիչ կկապվենք Ձեզ հետ և կտեղեկացնենք հետագա քայլերի մասին:</p><p style="margin-right:5%;margin-left:5%;font-size:small;color:black;text-align:center;">Եթե ունեք հարցեր կամ առաջարկություններ, կարող եք կապվել մեզ հետ <a href="https://www.facebook.com/innovities/" target="_blank" style="color:skyblue;display:inline;">facebook</a>-յան էջի միջոցով:</p><p style="color:black;text-align:center;font-size:small;">Հետևեք մեզ`</p><div style="margin-top:-1em;"><a href="https://www.facebook.com/innovities/" target="_blank"><div style="display:inline;"><img src="/images/fb_skyblue.png" style="display:inline;width:10%;height:10%;margin-left:33%;margin-right:0.3em;" /></div></a><a href="https://twitter.com/innovities" target="_blank"><div style="display:inline;"><img src="/images/twitter_skyblue.png" style="width:10%;height:10%;margin-right:0.3em;" /></div></a><a href="https://www.linkedin.com/company/innovities/" target="_blank"><div style="display:inline;"><img src="/images/in_skyblue.png" style="width:10%;height:10%;" /></div></a></div><button class="uk-modal-close-default" uk-close /></div>');
  });
}

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
