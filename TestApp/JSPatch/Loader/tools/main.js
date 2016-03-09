defineClass('JSPatchDemoViewController', {

viewDidLoad: function() {
        
self.super().viewDidLoad();
var view = self.view().subviews().firstObject();
var gestureRecognizer = require('UITapGestureRecognizer').alloc().initWithTarget_action(self, "tap");

 view.addGestureRecognizer(gestureRecognizer);
 view.setUserInteractionEnabled(YES);
                        console.log("我是第一次覆盖的方法");
},


tap: function() {
self.navigationController().popViewControllerAnimated(YES);
            console.log("打印东西");
},
});
