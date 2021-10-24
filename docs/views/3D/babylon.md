---
     title: babylon
     date: 2021-10-24
     tags:
       - 3D
     categories:
       - babylon
     sidebar: 'true'
---

# BABYLON
- 基础框架

```html
<template>
  <div>
    <canvas id="renderCanvas"></canvas>
  </div>
</template>
<script src="https://cdn.babylonjs.com/babylon.js"></script> 
<script src="https://cdn.babylonjs.com/loaders/babylonjs.loaders.min.js"></script>
<script src="https://code.jquery.com/pep/0.4.3/pep.js"></script>//触屏
```


```js
var canvas = document.getElementById("renderCanvas");
var engine = new BABYLON.Engine(canvas, true); 
//创建场景
const createScene =  () => {
    //获取HTML对象
  
    const scene = new BABYLON.Scene(engine);
    //创建相机
    const camera = new BABYLON.ArcRotateCamera("camera", -Math.PI / 2, Math.PI / 2.5, 3, new BABYLON.Vector3(0, 0, 0));
    //相机控制
    camera.attachControl(canvas, true);
    //灯光
    const light = new BABYLON.HemisphericLight("light", new BABYLON.Vector3(0, 1, 0));
    //盒子
    const box = BABYLON.MeshBuilder.CreateBox("box", {});
    return scene;
}
//启动渲染
engine.runRenderLoop(function () {
    scene.render();
});
//根据窗口变化
window.addEventListener("resize", function () {
   engine.resize();
});
```

- html展示3D model
```html
<script src="https://cdn.babylonjs.com/viewer/babylon.viewer.js">
</script>
<babylon model="Path to File"></babylon>
```
- 加载外部资源

```js
BABYLON.SceneLoader.ImportMeshAsync("", "/relative path/", "myFile"); 
BABYLON.SceneLoader.ImportMeshAsync("model1", "/relative path/", "myFile"); 
BABYLON.SceneLoader.ImportMeshAsync(["model1", "model2"], "/relative path/", "myFile");
```
- 坐标系(左手系)
```js
//显示坐标系  
showWorldAxis(size, scene) {
      var makeTextPlane = function (text, color, size) {
        var dynamicTexture = new BABYLON.DynamicTexture(
          "DynamicTexture",
          50,
          scene,
          true
        );
        dynamicTexture.hasAlpha = true;
        dynamicTexture.drawText(
          text,
          5,
          40,
          "bold 36px Arial",
          color,
          "transparent",
          true
        );
        var plane = BABYLON.Mesh.CreatePlane("TextPlane", size, scene, true);
        plane.material = new BABYLON.StandardMaterial(
          "TextPlaneMaterial",
          scene
        );
        plane.material.backFaceCulling = false;
        plane.material.specularColor = new BABYLON.Color3(0, 0, 0);
        plane.material.diffuseTexture = dynamicTexture;
        return plane;
      };
      var axisX = BABYLON.Mesh.CreateLines(
        "axisX",
        [
          BABYLON.Vector3.Zero(),
          new BABYLON.Vector3(size, 0, 0),
          new BABYLON.Vector3(size * 0.95, 0.05 * size, 0),
          new BABYLON.Vector3(size, 0, 0),
          new BABYLON.Vector3(size * 0.95, -0.05 * size, 0),
        ],
        scene
      );
      axisX.color = new BABYLON.Color3(1, 0, 0);
      var xChar = makeTextPlane("X", "red", size / 10);
      xChar.position = new BABYLON.Vector3(0.9 * size, -0.05 * size, 0);
      var axisY = BABYLON.Mesh.CreateLines(
        "axisY",
        [
          BABYLON.Vector3.Zero(),
          new BABYLON.Vector3(0, size, 0),
          new BABYLON.Vector3(-0.05 * size, size * 0.95, 0),
          new BABYLON.Vector3(0, size, 0),
          new BABYLON.Vector3(0.05 * size, size * 0.95, 0),
        ],
        scene
      );
      axisY.color = new BABYLON.Color3(0, 1, 0);
      var yChar = makeTextPlane("Y", "green", size / 10);
      yChar.position = new BABYLON.Vector3(0, 0.9 * size, -0.05 * size);
      var axisZ = BABYLON.Mesh.CreateLines(
        "axisZ",
        [
          BABYLON.Vector3.Zero(),
          new BABYLON.Vector3(0, 0, size),
          new BABYLON.Vector3(0, -0.05 * size, size * 0.95),
          new BABYLON.Vector3(0, 0, size),
          new BABYLON.Vector3(0, 0.05 * size, size * 0.95),
        ],
        scene
      );
      axisZ.color = new BABYLON.Color3(0, 0, 1);
      var zChar = makeTextPlane("Z", "blue", size / 10);
      zChar.position = new BABYLON.Vector3(0, 0.05 * size, 0.9 * size);
    },
  }
  
 //设置模型相对坐标系
  messhChild.parent = meshParent
```

- 地面
```js
//创建地板
const ground = BABYLON.MeshBuilder.CreateGround("ground", {width:10, height:10});
```
- 地形
```js
const largeGround = BABYLON.MeshBuilder.CreateGroundFromHeightMap("largeGround", "url to height map", 
    {width:150, height:150, subdivisions: 20, minHeight:0, maxHeight: 10});
```
- 模型
```js
//初始化大小
const box = BABYLON.MeshBuilder.CreateBox("box", {width: 2, height: 1.5, depth: 3})
//缩放
box.scaling.x = 2;
box.scaling.y = 1.5;
box.scaling.z = 3;
box.scaling = new BABYLON.Vector3(2, 1.5, 3);
```

- 模型位置

```js
box.position.x = -2;
box.position.y = 4.2;
box.position.z = 0.1;
box.position = new BABYLON.Vector3(-2, 4.2, 0.1);
```

- 模型旋转

```js
//基于y轴旋转
box.rotation.y = Math.PI / 4;
box.rotation.y = BABYLON.Tools.ToRadians(45);
```
- 组合
```js
//组合两个模型
const house = BABYLON.Mesh.MergeMeshes([box, roof], true, false, null, false, true);
//复制
instanceHouse = house.createInstance("instanceHouse")
```

- 材质
```js
//新建一个材质
const material = new BABYLON.StandardMaterial("name", scene);
//设置材质颜色
groundMat.diffuseColor = new BABYLON.Color3(0, 1, 0);
ground.material = groundMat; 

//使用图片材质
roofMat.diffuseTexture = new BABYLON.Texture(scene);

//设置不同面材质
faceUV = [];
faceUV[0] = new BABYLON.Vector4(0.5, 0.0, 0.75, 1.0); //背面
faceUV[1] = new BABYLON.Vector4(0.0, 0.0, 0.25, 1.0); //正面
faceUV[2] = new BABYLON.Vector4(0.25, 0, 0.5, 1.0); //右面
faceUV[3] = new BABYLON.Vector4(0.75, 0, 1.0, 1.0); //左面
const box = BABYLON.MeshBuilder.CreateBox("box", {faceUV: faceUV, wrap: true});
```
- 动画
```js
const animWheel = new BABYLON.Animation("wheelAnimation", "rotation.y", 30, BABYLON.Animation.ANIMATIONTYPE_FLOAT, BABYLON.Animation.ANIMATIONLOOPMODE_CYCLE);
const wheelKeys = []; 

//初始关键帧
wheelKeys.push({
    frame: 0,
    value: 0
});

//第三十帧，旋转2圈
wheelKeys.push({
    frame: 30,
    value: 2 * Math.PI
});
animWheel.setKeys(wheelKeys);
//设置动画
wheelRB.animations = [];
wheelRB.animations.push(animWheel);
//执行动画从第0帧到第30帧，循环
scene.beginAnimation(wheelRB, 0, 30, true);
```
- 移动
```js
mesh.movePOV(0, 0, 6)//移动
mesh.rotate(axis, angle, BABYLON.Space.LOCAL);//旋转
//每帧结束后下一个动作
scene.onBeforeRenderObservable.add(()=>{
    
})
```
- 声音
```js
//添加声音
const sound = new BABYLON.Sound("sound", "url to sound file", scene);
//播放声音
sound.play();
```

