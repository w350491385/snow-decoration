import instance from '../../utils/httpRequest'

const preUrlPath = window.SITE_CONFIG['baseUrl']

// 查询所有岗位
const findAllSysposition = {
  p: ['get,/tx/sysposition/select'],
  r: () => {
    return instance.get(`${preUrlPath}/tx/sysposition/select`)
  }
}
// 查询所有角色
const findAllRole = {
  p: ['get,/sys/role/select'],
  r: () => {
    return instance.get(`${preUrlPath}/sys/role/select`)
  }
}
// 查询所有用户
const findAllUser = {
  p: ['get,/sys/user/select'],
  r: () => {
    return instance.get(`${preUrlPath}/sys/user/select`)
  }
}
// 查询部门（分层级）
const findAllDeptMulti = {
  p: ['get,/sys/dept/multiSelect'],
  r: () => {
    return instance.get(`${preUrlPath}/sys/dept/multiSelect`)
  }
}
// 查询部门（无分层）
const findAllDept = {
  p: ['get,/sys/dept/list'],
  r: () => {
    return instance.get(`${preUrlPath}/sys/dept/list`)
  }
}
// 新增用户
const addOrUpUser = {
  p: ['put,/sys/user/save'],
  r: (params) => {
    if (params.userId) {
      return instance.post(`${preUrlPath}/sys/user/update`, params)
    } else {
      return instance.post(`${preUrlPath}/sys/user/save`, params)
    }
  }
}
// 查询字典
const findDictByType = {
  p: ['get,/sys/dict/listByType'],
  r: (params) => {
    return instance.get(`${preUrlPath}/sys/dict/listByType`, {params})
  }
}
// 查询小区
const findCommunity = {
  p: ['get,/tx/community/all'],
  r: (params) => {
    return instance.get(`${preUrlPath}/tx/community/all`, {params})
  }
}
export {
  findAllSysposition,
  findAllRole,
  findAllUser,
  findAllDeptMulti,
  findAllDept,
  addOrUpUser,
  findDictByType,
  findCommunity
}
