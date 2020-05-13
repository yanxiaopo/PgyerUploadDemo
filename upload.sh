#!/usr/bin/env bash
        openLog=false
        apkType="debug"
        uat=false
        dis=""
        paramsOk=true
        savePPK=false


    clearApk(){
        rm -rf ./debug/build/outputs/apk
    }

    deleteApk(){
        rm -rf ./*.apk
    }

    upload(){
          apiKey='***'
          uKey='***'

          if [[ ${uat} == true ]];then
                apiKey='***'
                uKey='***'
          fi
          if [[ ${dis} == "" ]];then
           dis=$(git log --pretty=format:"%s" -3)
          fi
          echo
          echo "打包完成 开始上传"
          echo $dis
          ./gradlew -PdescProp=$dis pgyer
          echo
          echo "---------------------上传完成---------------------"
    }

    ppApk(){


      assembleName="assemble$apkType"

            echo
            echo "------------------Android 打包开始---------------------"
            echo "|   openLog: $openLog"
            echo "|   apkType: $assembleName"
            echo "|   是否UAT: $uat"
            echo "|   版本描述: $dis"
            echo "|   是否保存APK: $savePPK"
            echo "-------------------------------------------------------"
            echo
 
    clearApk

    deleteApk
 
        if [[ ${openLog} == true ]] ;then
          ./gradlew --no-daemon ${assembleName} -i
          else
          ./gradlew --no-daemon ${assembleName}
        fi
 
        cp -r app/build/outputs/apk/${apkType}/*.apk .
        assembleApk=`ls *.apk`
        if upload ${assembleApk}; then
            if [[ ${savePPK} == false ]]; then
                deleteApk
            fi
        fi
    }
 
    HELP(){
            echo
            echo "-------------------upload help--------------------------"
            echo "|   -d 添加上传蒲公英是的版本描述                      "
            echo "|   -t release、test.                                   "
            echo "|   -p 是否保存APK 只需调用即可 不需要传参数           "
            echo "|   -u 是否是UAT包 只需调用即可 不需要传参数           "
            echo "|   -i 控制是否输出打包日志 只需调用即可 不需要传参数  "
            echo "|   -h 帮助                                            "
            echo "|   -默认打Debug包                                    "
            echo "--------------------------------------------------------"
            echo
    }
 
 
    opt=`getopt iuhpt:d: "$@"`
        set -- ${opt}
        while [[ -n "$1" ]]
        do
        case $1 in
            -t)
            echo "-t 选项的参数值是：$2"
               if [[ $2 != "" ]] ;then
                         apkType=$2
                    fi
            shift
            ;;
        -d)
        echo "发现 -d 选项"
            echo "-d 选项的参数值是：$2"
                 if [[ $2 != "" ]] ;then
                         dis=$2
                       fi
            shift
            ;;
        -i)
             openLog=true
            ;;
        -u)
             uat=true
            ;;
        -h)
             paramsOk=false
             HELP
             ;;
         -p)
             savePPK=true
             ;;
        --)
            shift
            break
            ;;
         ?)
             echo "未知选项:"$1""
             paramsOk=false
             HELP
            ;;
    esac
    shift
    done
 
        if ${paramsOk}; then
           ppApk
        fi
 
ff=unix.