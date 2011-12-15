$(function () {

  var
    T = TenThousandHours,
    node = $('#vis'),
    container;

  if (node.length > 0) {
    container = node[0];
    $.getJSON(getDataURL(), function (o) {
      console.log(container);
      console.log(o);
      drawVis(container, o);
    });
  }

  function drawVis (container, data) {
    vis = new T.Vis(node[0], data);
  }

  function getURL () {
    return window.location.href;
  }

  function getDataURL () {
    var
      url = getURL(),
      parts = url.split(/(\d+$)/),
      base = parts[0],
      id = parts[1];

    return base + 'data/' + id;
  }
});
