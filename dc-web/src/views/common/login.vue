<template>
  <div class="site-wrapper site-page--login">
    <div class="site-content__wrapper">
      <div class="site-content">
        <div class="brand-info">
          <h2 class="brand-info__text">流雪家装云平台</h2>
          <p class="brand-info__intro">免费的装修管理一站式服务ERP,拥有活跃的交流互动社区,及时回复用户反馈改良产品.</p>
        </div>
        <div class="login-main">
          <h3 class="login-title">登录</h3>
          <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" status-icon>
            <el-form-item prop="userName">
              <el-input v-model="dataForm.userName" placeholder="邮箱或手机号码"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="dataForm.password" type="password" placeholder="密码" value="admin"></el-input>
            </el-form-item>
            <el-form-item prop="captcha">
              <el-row :gutter="20">
                <el-col :span="14">
                  <el-input v-model="dataForm.captcha" placeholder="验证码">
                  </el-input>
                </el-col>
                <el-col :span="10" class="login-captcha">
                  <img :src="captchaPath" @click="getCaptcha()" alt="">
                </el-col>
              </el-row>
            </el-form-item>

            <el-form-item>
              <el-button class="login-btn-submit" type="primary" @click="dataFormSubmit()">登录</el-button>
            </el-form-item>
            <el-form-item>
              <el-button type="text" @click="regist">免费注册</el-button>
              <el-button type="text" @click="forget">忘记密码</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
      <el-dialog :visible.sync="showRegist" title="账号注册">
        <el-form :model="registForm" ref="registForm" :rules="registRule">
          <el-form-item label="用户名" label-width="120px" prop="email">
            <el-input v-model="registForm.email" placeholder="邮箱">
              <el-button slot="append" @click="registCaptcha" type="primary" :disabled="isDisabled">{{buttonName}}</el-button>
            </el-input>
          </el-form-item>
          <el-form-item label="验证码" label-width="120px" prop="code">
            <el-input v-model="registForm.code" placeholder="邮箱收到的验证码"></el-input>
          </el-form-item>
          <el-form-item label="密码" label-width="120px" prop="password1">
            <el-input v-model="registForm.password1" type="password"></el-input>
          </el-form-item>
          <el-form-item label="确认密码" label-width="120px" prop="password2">
            <el-input v-model="registForm.password2" type="password"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="resetRegist">重 置</el-button>
          <el-button type="primary" @click="registSubmit" :loading=registLoading>确 定</el-button>
        </div>
      </el-dialog>
      <el-dialog :visible.sync="showForget" title="忘记密码">
        <el-form :model="forgetForm" ref="forgetForm" :rules="forgetRule">
          <el-form-item label="邮箱" label-width="120px" prop="email">
            <el-input v-model="forgetForm.email" placeholder="邮箱">
              <el-button slot="append" @click="forgetCaptcha" type="primary" :disabled="isDisabled">{{buttonName}}</el-button>
            </el-input>
          </el-form-item>
          <el-form-item label="验证码" label-width="120px" prop="code">
            <el-input v-model="forgetForm.code" placeholder="邮箱收到的验证码"></el-input>
          </el-form-item>
          <el-form-item label="新密码" label-width="120px" prop="password1">
            <el-input v-model="forgetForm.password1" type="password"></el-input>
          </el-form-item>
          <el-form-item label="确认新密码" label-width="120px" prop="password2">
            <el-input v-model="forgetForm.password2" type="password"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="resetForget">重 置</el-button>
          <el-button type="primary" @click="forgetSubmit">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
  import {getUUID, saveToken} from '@/utils'
  import {isEmail} from '@/utils/validate'

  export default {
    data () {
      var validateConfirmPassword = (rule, value, callback) => {
        if (this.registForm.password1 !== value) {
          callback(new Error('确认密码与新密码不一致'))
        } else {
          callback()
        }
      }
      var validateForgetPass = (rule, value, callback) => {
        if (this.forgetForm.password1 !== value) {
          callback(new Error('确认密码与新密码不一致'))
        } else {
          callback()
        }
      }
      return {
        dataForm: {
          userName: '',
          password: '',
          uuid: '',
          captcha: ''
        },
        registForm: {
          emmail: '',
          password1: '',
          password2: '',
          code: '',
          cpName: '',
          phone: '',
          ceo: ''
        },
        registLoading: false,
        forgetForm: {
          emmail: '',
          code: '',
          password1: '',
          password2: ''
        },
        forgetLoading: false,
        dataRule: {
          userName: [
            {required: true, message: '帐号不能为空', trigger: 'blur'}
          ],
          password: [
            {required: true, message: '密码不能为空', trigger: 'blur'}
          ],
          captcha: [
            {required: true, message: '验证码不能为空', trigger: 'blur'}
          ]
        },
        forgetRule: {
          email: [
            {required: true, message: '请输入邮箱', trigger: 'blur'}
          ],
          code: [
            {required: true, message: '请输入验证码', trigger: 'blur'}
          ],
          password1: [
            {required: true, message: '请输入新密码', trigger: 'blur'}
          ],
          password2: [
            {required: true, message: '请再次输入新密码', trigger: 'blur'},
            {validator: validateForgetPass, trigger: 'blur'}
          ]
        },
        registRule: {
          email: [
            {required: true, message: '邮箱账号不能为空', trigger: 'blur'}
          ],
          password1: [
            {required: true, message: '请输入密码', trigger: 'blur'}
          ],
          password2: [
            {required: true, message: '请输入确认密码', trigger: 'blur'},
            {validator: validateConfirmPassword, trigger: 'blur'}
          ],
          code: [
            {required: true, message: '请输入验证码', trigger: 'blur'}
          ]
        },
        captchaPath: '',
        showRegist: false,
        showForget: false,
        buttonName: '发送验证码',
        isDisabled: false,
        time: 60
      }
    },
    created () {
      this.getCaptcha()
    },
    methods: {
      // 注册
      regist () {
        this.showRegist = true
        this.resetRegist()
      },
      // 忘记密码
      forget () {
        this.showForget = true
      },
      resetRegist () {
        this.registForm.emmail = ''
        this.registForm.ceo = ''
        this.registForm.cpName = ''
        this.registForm.phone = ''
        this.registForm.password1 = ''
        this.registForm.code = ''
        this.registForm.password2 = ''
      },
      resetForget () {
        this.forgetForm.code = ''
        this.forgetForm.emmail = ''
        this.forgetForm.password1 = ''
        this.forgetForm.password2 = ''
      },
      registCaptcha () {
        if (!isEmail(this.registForm.email)) {
          this.$message.error('请输入正确的邮箱')
          return
        }
        this.$http({
          url: this.$http.adornUrl(`/sys/registMail/${this.registForm.email}`),
          method: 'post',
          data: this.$http.adornData({})
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.$message.success('验证码已发送')
          } else {
            this.$message.error(data.msg)
          }
        })
        let me = this
        me.isDisabled = true
        let interval = window.setInterval(function () {
          me.buttonName = '（' + me.time + '秒）后重新发送'
          --me.time
          if (me.time < 0) {
            me.buttonName = '重新发送'
            me.time = 60
            me.isDisabled = false
            window.clearInterval(interval)
          }
        }, 1000)
      },
      forgetCaptcha () {
        if (!isEmail(this.forgetForm.email)) {
          this.$message.error('请输入正确的邮箱')
          return
        }
        this.$http({
          url: this.$http.adornUrl(`/sys/forgetMail/${this.forgetForm.email}`),
          method: 'post',
          data: this.$http.adornData({})
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.$message.success('验证码已发送')
          } else {
            this.$message.error(data.msg)
          }
        })
        let me = this
        me.isDisabled = true
        let interval = window.setInterval(function () {
          me.buttonName = '（' + me.time + '秒）后重新发送'
          --me.time
          if (me.time < 0) {
            me.buttonName = '重新发送'
            me.time = 60
            me.isDisabled = false
            window.clearInterval(interval)
          }
        }, 1000)
      },
      // 登录提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl('/sys/login'),
              method: 'post',
              data: this.$http.adornData({
                'username': this.dataForm.userName,
                'password': this.dataForm.password,
                'uuid': this.dataForm.uuid,
                'captcha': this.dataForm.captcha
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                saveToken(data.token)
                this.$router.replace({name: 'home'})
              } else {
                this.getCaptcha()
                this.$message.error(data.msg)
              }
            })
          }
        })
      },
      // 注册提交
      registSubmit () {
        this.$refs['registForm'].validate((valid) => {
          if (valid) {
            this.registLoading = true
            this.$http({
              url: this.$http.adornUrl('/sys/registPerson'),
              method: 'post',
              data: this.$http.adornData({
                'email': this.registForm.email,
                'password': this.registForm.password1,
                'phone': this.registForm.phone,
                'cpName': this.registForm.cpName,
                'ceo': this.registForm.ceo,
                'code': this.registForm.code
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message.success('注册成功')
                this.showRegist = false
              } else {
                this.$message.error(data.msg)
              }
              this.registLoading = false
            })
          }
        })
      },
      // 修改密码提交
      forgetSubmit () {
        this.$refs['forgetForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl('/sys/forget'),
              method: 'post',
              data: this.$http.adornData({
                'email': this.forgetForm.email,
                'password': this.forgetForm.password1,
                'code': this.forgetForm.code
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message.success('密码修改成功')
                this.showRegist = false
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      },
      // 获取验证码
      getCaptcha () {
        this.dataForm.uuid = getUUID()
        this.captchaPath = this.$http.adornUrl(`/captcha.jpg?uuid=${this.dataForm.uuid}`)
      }
    }
  }
</script>

<style lang="scss">
  .site-wrapper.site-page--login {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgba(38, 50, 56, .6);
    overflow: hidden;

    &:before {
      position: fixed;
      top: 0;
      left: 0;
      z-index: -1;
      width: 100%;
      height: 100%;
      content: "";
      background-image: linear-gradient(to right , #7A88FF, #7AFFAF);
      background-size: cover;
    }

    .site-content__wrapper {
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      padding: 0;
      margin: 0;
      overflow-x: hidden;
      overflow-y: auto;
      background-color: transparent;
    }

    .site-content {
      min-height: 100%;
      padding: 30px 500px 30px 30px;
    }

    .brand-info {
      margin: 220px 100px 0 90px;
      color: #fff;
      text-align: center;
    }

    .brand-info__text {
      margin: 0 0 22px 0;
      font-size: 48px;
      font-weight: 400;
      text-transform: uppercase;
    }

    .brand-info__intro {
      margin: 10px 0;
      font-size: 16px;
      line-height: 1.58;
      opacity: .6;
    }

    .login-main {
      position: absolute;
      top: 0;
      right: 0;
      padding: 150px 60px 180px;
      width: 470px;
      min-height: 100%;
      background-color: #fff;
    }

    .login-title {
      font-size: 16px;
    }

    .login-captcha {
      overflow: hidden;

      > img {
        width: 100%;
        cursor: pointer;
      }
    }

    .login-btn-submit {
      width: 100%;
    }
  }
</style>
