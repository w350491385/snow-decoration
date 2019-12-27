import instance from '../../../utils/httpRequest'

const preUrlPath = window.SITE_CONFIG['baseUrl']

// 根据id查询用户信息
const findUserInfo = {
  p: ['get,/sys/user/info/**'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/user/info/${params}`)
  }
}
// 根据id查询角色id列表
const findRoleIdList = {
  p: ['get,/sys/user/findRoleIdList'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/user/findRoleIdList/${params}`)
  }
}
// 根据id查询岗位id列表
const findPositionIdList = {
  p: ['get,/sys/user/findPositionIdList'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/user/findPositionIdList/${params}`)
  }
}
// 根据id查询个人视野id列表
const findPersonViewIdList = {
  p: ['get,/sys/user/findPersonViewIdList'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/user/findPersonViewIdList/${params}`)
  }
}
// 根据id查询部门视野id列表
const findDeptViewIdList = {
  p: ['get,/sys/user/findDeptViewIdList'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/user/findDeptViewIdList/${params}`)
  }
}
// 更新用户角色
const updateUserRole = {
  p: ['put,/sys/user/role'],
  r: (params) => {
    return instance.post(`${preUrlPath}/sys/user/role`, params)
  }
}
// 更新用户服务岗位
const updateUserPosition = {
  p: ['put,/sys/user/position'],
  r: (params) => {
    return instance.post(`${preUrlPath}/sys/user/position`, params)
  }
}

// 更新个人视野
const updateUserPersonView = {
  p: ['put,/sys/user/personview'],
  r: (params) => {
    return instance.post(`${preUrlPath}/sys/user/personview`, params)
  }
}

// 更新部门视野
const updateUserDeptView = {
  p: ['put,/sys/user/deptview'],
  r: (params) => {
    return instance.post(`${preUrlPath}/sys/user/deptview`, params)
  }
}

// 离职操作
const retired = {
  p: ['post,/sys/user/retired'],
  r: (userId) => {
    return instance.post(`${preUrlPath}/sys/user/retired`, userId)
  }
}

// 转客户
const exchangeClient = {
  p: ['put,/sys/user/exchange'],
  r: (params) => {
    return instance.post(`${preUrlPath}/sys/user/exchange`, params)
  }
}
export {
  exchangeClient,
  findUserInfo,
  updateUserRole,
  retired,
  updateUserPosition,
  updateUserPersonView,
  updateUserDeptView,
  findRoleIdList,
  findPositionIdList,
  findPersonViewIdList,
  findDeptViewIdList
}
