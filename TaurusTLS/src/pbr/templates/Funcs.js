function setHL(id)
{
  // all objects with same id get the same classname..
  var obj = document.all.item(id);
  var len = obj.length;
    
  for (i=0;i<len;i++)
  {
    if (obj(i).className == "Id")
    {
      obj(i).className="IdHL";
    }
    else
      if (obj(i).className == "EId")
      {
        obj(i).className = "EIdHL";
      }
      else
        if (obj(i).className == "XId")
        {
          obj(i).className = "XIdHL";
        }
  }
}

function setNormal(id)
{
  // all objects with same id get the same classname..
  var obj = document.all.item(id);
  var len = obj.length;
    
  for (i=0;i<len;i++)
  {
    if (obj(i).className == "IdHL")
    {
      obj(i).className="Id";
    }
    else
      if (obj(i).className == "EIdHL")
      {
        obj(i).className = "EId";
      }
      else
        if (obj(i).className == "XIdHL")
        {
          obj(i).className = "XId";
        }
  }
}

function doOver()
{
  var e = window.event.srcElement;

  if (e.id.indexOf("I") != -1) 
  {
    setHL(e.id);
  }
}

function doOut()
{
  var e = window.event.srcElement;

  if (e.id.indexOf("I") != -1) 
  {
    setNormal(e.id);
  }
}

function window.onload()
// link to events
{
  document.onmouseover = doOver;
  document.onmouseout = doOut;
}
