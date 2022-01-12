$(function () {
  var w = $('.canvas-wrapper').width();
  var h = $('.canvas-wrapper').height();
  $('#canvas').attr('width', w);
  $('#canvas').attr('height', h);
  // ダウンロード
  $("#download").on('click', function () {
    let canvas = document.getElementById("canvas");
    let link = document.createElement("a");
    link.href = canvas.toDataURL("image/png");
    link.download = "outfit.png";
    link.click();
  });
  // 即時関数。関数を定義すると同時に実行する。
  (function () {
    var canvas = new fabric.Canvas('canvas', {
      // preserveObjectStacking: false
    });
    if (JSON.parse(document.getElementById("selected-bottoms-true").dataset.json)) {
      N = JSON.parse(document.getElementById("selected-bottoms-count").dataset.json);
      var srcs_bottoms = [];
      for (var n = 0; n < N; n++) {
        srcs_bottoms.push(JSON.parse(document.getElementById(`selected-bottoms-${n}`).dataset.json))
      };
    }

    if (JSON.parse(document.getElementById("selected-tops-true").dataset.json)) {
      N = JSON.parse(document.getElementById("selected-tops-count").dataset.json);
      var srcs_tops = [];
      for (var n = 0; n < N; n++) {
        srcs_tops.push(JSON.parse(document.getElementById(`selected-tops-${n}`).dataset.json))
      };
    }

    for (var i in srcs_bottoms) {
      fabric.Image.fromURL(`${srcs_bottoms[i]}`, function (oImg) {
        bottoms = oImg;
        oImg.setControlsVisibility({
          mt: false,	// middle top
          mb: false,	// middle bottom
          ml: false,	// middle left
          mr: false,	// middle right
          //br: false,	// bottom right
          mtr: false,	// middle top rotete
        }); // 各コントロールをON/OFF制御
        canvas.add(oImg);
      });
    };
    for (var i in srcs_tops) {
      fabric.Image.fromURL(`${srcs_tops[i]}`, function (oImg) {
        tops = oImg;
        oImg.setControlsVisibility({
          mt: false,	// middle top
          mb: false,	// middle bottom
          ml: false,	// middle left
          mr: false,	// middle right
          //br: false,	// bottom right
          mtr: false,	// middle top rotete
        }); // 各コントロールをON/OFF制御
        canvas.add(oImg);
      });
    };

    function deleteObj() {
      //選択されているオブジェクトを削除する。
      let activeObjects = canvas.getActiveObjects();

      if (activeObjects != null) {
        if (confirm('選択された画像を削除しますか？')) {
          activeObjects.forEach(obj => {

            //対象オブジェクトを削除
            canvas.remove(obj);

            //矩形のIDとcanvas.item紐づけ用配列も削除する。
            let arrIndex = arrayRect.indexOf(obj.id);
            arrayRect.splice(arrIndex, 1);
          });
        }
      } else {
        alert("オブジェクトが選択されていません。");
      }
    }
    deleteBtn.addEventListener('click', deleteObj, false);
  })();
  window.onload = function () {
    // 直接順番指定
    tops.moveTo(100);
    bottoms.moveTo(0);
  };
});
