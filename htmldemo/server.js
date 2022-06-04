const Koa = require('koa') //引入Koa构造函数,服务器
const router = require('koa-router')() //路由
// const static = require('koa-static')    //静态目录
// const views = require('koa-views') //视图管理模块
// const nunjucks = require('nunjucks') //模板引擎
const parser = require('koa-parser') //可以进行post引用
// const axios = require("axios")
const app = new Koa(); //创建应用

app.use(parser());
//引入一个中间件，中间件即是一个函数
// app.use(async(ctx)=>{
// 	ctx.body = 'hello koa'
// })

//__dirname 可以直接获取当前项目的路径

//koa-views引用nunjucks模板引擎
// app.use(views(__dirname + '/views', {
// 	map: {
// 		html: 'nunjucks'
// 	}
// }));

//获取通过get得到的值
// router.get('/login',async ctx=>{
// 	let username = ctx.query.username;
// 	let password = ctx.query.password;
// 	await ctx.render('home',{
// 		username:username,
// 		password:password
// 	})
// })

//获取通过post得到的值
// router.post('/login', async ctx => {
// 	let username = ctx.request.body.username;
// 	let password = ctx.request.body.password;
// 	await ctx.render('home', {
// 		username: username,
// 		password: password
// 	})
// })


// app.use(async (ctx) => {
// 	await ctx.render('index',{title:"hello nunjucks"})
// })

// 引用 koa-router
app.use(router.routes());
//引用模板的路由方法
router.get('/', async (ctx) => {
	let studentList = ['小明', '小红', '小亮']
	await ctx.render('index', {
		title: '首页',
		studentList: studentList,
		isLogin: false,
		username: 'admin'

	})
})

let dataList = ["香蕉","苹果","鸭梨"];

//get查看
router.get("/fruits", ctx => {
    ctx.body = dataList;
})
//post添加
router.post("/fruits", ctx => {
    let fruit = ctx.request.body.fruit;
    dataList.push(fruit);
    ctx.body = dataList;
})

//put修改
router.put("/fruits/:id", ctx => {
    let id = ctx.params.id;
    let fruit = ctx.request.body.fruit;
    dataList.splice(id,1,fruit);
    ctx.body = dataList;
})
//delete删除
router.delete("/fruits/:id", ctx => {
    let id = ctx.params.id;
    dataList.splice(id,1);
    ctx.body = dataList;
})


router.get('/images',async (ctx)=>{
	await ctx.render('images')
})

router.get("/video", async (ctx) => {
	await ctx.render('index', {
		title: '视频'
	})
});

router.get("/list",async (ctx) => {
	await ctx.render('list')
})
// //引用 koa-static
// app.use(static(__dirname + "/public"))

// console.log(__dirname,'当前静态路径')
//非模板的路由方法
// router.get('/',async(ctx)=>{
// 	ctx.body = `
// 	<h1>hello</h1>
// 	<p>标题</p>
// 	<img src="images/01.jpg" >
// 	`

// })

// router.get('/video',async (ctx) =>{
// 	ctx.body = 'video page'
// })

// router.get('/images',async (ctx)=>{
// 	ctx.body = `
// 	<p>这是图片</p>
// 	<img src="images/02.jpg" >
// 	`
// })

app.listen(3000, () => {
	console.log('server is running')
}) //设置监听端口
