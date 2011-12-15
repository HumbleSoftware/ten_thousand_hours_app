$(function () {

  var
    T = TenThousandHours,
    node = $('#vis'),
    container;

  if (node.length > 0) {
    container = node[0];
    $.getJSON('http://devtop:3000/projects/10/entries', function (o) {
      console.log(container);
      console.log(o);
      drawVis(container, o);
    });
  }

  function drawVis (container, data) {
    vis = new T.Vis(node[0], data);
  }
});
